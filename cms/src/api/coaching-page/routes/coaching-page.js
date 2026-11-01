'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::coaching-page.coaching-page', {
  config: { find: { auth: false } },
});
