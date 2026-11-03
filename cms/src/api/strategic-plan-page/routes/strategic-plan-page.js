'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::strategic-plan-page.strategic-plan-page', {
  config: { find: { auth: false } },
});
