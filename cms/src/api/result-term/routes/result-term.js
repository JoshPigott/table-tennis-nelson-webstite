'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::result-term.result-term', {
  config: { find: { auth: false } },
});
