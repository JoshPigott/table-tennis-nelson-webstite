'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::complaints-page.complaints-page', {
  only: ['find'],
  config: { find: { auth: false } },
});
