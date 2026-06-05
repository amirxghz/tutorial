'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::pub.pub', ({ strapi }) => ({

  async find(ctx) {
    const pubs = await strapi.entityService.findMany('api::pub.pub', { populate: '*' });
    return pubs;
  },

  async affordable(ctx) {
    const maxPrice = ctx.query.maxPrice || 15;
    const pubs = await strapi.service('api::pub.pub').getAffordablePubs(maxPrice);
    return pubs;
  }

}));