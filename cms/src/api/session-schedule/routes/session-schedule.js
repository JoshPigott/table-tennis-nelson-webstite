'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::session-schedule.session-schedule', {
  config: {
    find: { auth: false },
  },
});
