'use strict';

const { factories } = require('@strapi/strapi');

module.exports = factories.createCoreRouter('api::fee-schedule.fee-schedule', {
  config: {
    find: { auth: false },
  },
});
