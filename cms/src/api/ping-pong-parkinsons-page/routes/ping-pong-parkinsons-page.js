'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::ping-pong-parkinsons-page.ping-pong-parkinsons-page', {
  config: { find: { auth: false } },
});
