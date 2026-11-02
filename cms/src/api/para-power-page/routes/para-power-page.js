'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::para-power-page.para-power-page', {
  config: { find: { auth: false } },
});
