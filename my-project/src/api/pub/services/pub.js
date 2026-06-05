'use strict';

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::pub.pub', ({ strapi }) => 
    ({

  async getAffordablePubs(maxPrice) {
    const allPubs = await strapi.entityService.findMany('api::pub.pub', {
      populate: '*',
      filters: 
      {
        avgPrice: { $lte: maxPrice }
      }
    });
    return allPubs;
  }

}));