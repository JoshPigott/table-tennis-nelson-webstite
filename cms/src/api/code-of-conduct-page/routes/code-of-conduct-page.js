'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::code-of-conduct-page.code-of-conduct-page', {
  config: { find: { auth: false } },
});
