# syntax=docker/dockerfile:1
FROM node:24-bookworm-slim AS build
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends python3 make g++ ca-certificates && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json ./
RUN npm ci
COPY cms/package.json cms/package-lock.json ./cms/
RUN cd cms && npm ci
COPY . .

# Apply production configuration inside the image; local Strapi stays unchanged.
COPY <<'JS' ./cms/config/server.js
module.exports = ({ env }) => ({
  host: '0.0.0.0', port: env.int('PORT', 8080), url: env('PUBLIC_URL'),
  proxy: { koa: true }, app: { keys: env.array('APP_KEYS') },
  dirs: { public: env('PUBLIC_DIRECTORY', '/data/public') },
});
JS
COPY <<'JS' ./cms/config/database.js
module.exports = ({ env }) => ({ connection: {
  client: 'sqlite', connection: { filename: env('DATABASE_FILENAME', '/data/data.db') },
  useNullAsDefault: true,
}});
JS
COPY <<'JS' ./cms/config/middlewares.js
module.exports = [
  'global::website', 'strapi::logger', 'strapi::errors', 'strapi::security',
  'strapi::cors', 'strapi::poweredBy', 'strapi::query', 'strapi::body',
  'strapi::session', 'strapi::favicon', 'strapi::public',
];
JS
COPY <<'JS' ./cms/src/middlewares/website.js
module.exports = (_config, { strapi }) => require('koa-static')(require('path').join(strapi.dirs.app.root, 'website'), {
  index: 'index.html', maxage: 0,
  setHeaders(response) {
    response.setHeader('Cache-Control', 'no-cache');
    response.setHeader('X-Content-Type-Options', 'nosniff');
  },
});
JS

ARG PUBLIC_STRAPI_URL=https://table-tennis-nelson-production.up.railway.app
ARG PUBLIC_URL=https://table-tennis-nelson-production.up.railway.app
RUN PUBLIC_STRAPI_URL="$PUBLIC_STRAPI_URL" npm run build
RUN NODE_ENV=production PUBLIC_URL="$PUBLIC_URL" STRAPI_TELEMETRY_DISABLED=true npm --prefix cms run build

FROM node:24-bookworm-slim AS runtime
WORKDIR /app
# The existing Railway volume contains the migrated database and uploads.
ENV NODE_ENV=production PORT=8080 DATABASE_FILENAME=/data/data.db STRAPI_TELEMETRY_DISABLED=true
COPY --from=build /app/cms/ ./
COPY --from=build /app/dist/ ./website/
EXPOSE 8080
CMD ["sh", "-c", "test -f \"$DATABASE_FILENAME\" || { echo 'Persistent CMS database is missing; restore it before starting.'; exit 1; }; exec npm start"]
