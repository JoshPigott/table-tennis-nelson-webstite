'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::booking-page.booking-page', {
  only: ['find'],
  config: { find: { auth: false } },
});
