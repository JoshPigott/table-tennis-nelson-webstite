# Table Tennis Nelson

Astro website with a Strapi CMS in `cms/`.

## Run locally

In separate terminals, run:

```sh
npm run cms:dev
npm run dev
```

## Edit the sessions page

Open <http://localhost:1337/admin>, then choose **Content Manager → Single Types → Sessions**. The seven weekday sections each contain a list of sessions. Add, remove, or drag sessions to change their order. Each session has a title, time, description, a **School Terms Only** switch, optional highlights (one per line), and an optional contact email. Save your changes, then reload <http://localhost:4321/sessions/>.

The sessions page loads current content from Strapi when it opens. In local development it uses `http://localhost:1337`. For a deployed website, set `PUBLIC_STRAPI_URL` to the public Strapi address when building Astro. Strapi must be reachable from visitors' browsers. If it is unavailable, the page shows an error message instead of session listings.

Strapi stores edits in its database (`cms/.tmp/data.db` locally), which is not committed to Git. A new database has no sessions until you enter and save them in Strapi.
