<template>
  <li class="product-card">
    <img :src="'/' + product.img">
    <div class="product-details">
      <div class="title">{{product.product_code}}</div>
      <div class="notes">{{product.roasting_notes}}</div>
      <div class="roasted">Roasted on: {{product.time_roasted | moment}}</div>
      <div class="price">Price per bag: <span class="pricenum">{{product.price}}</span></div>
    </div>
  </li>
</template>

<script>
import moment from 'moment';

export default {
  name: 'ProductCard',
  props: ['product'],
  filters: {
    moment(date) {
      return moment(date).format('MMMM Do');
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
ul {
  list-style-type: none;
  padding: 0;
}
li.product-card {
  display: flex;
  margin: 24px 0;
  width: 600px;
}
li.product-card > img {
  width: 156px;
}
li.product-card > div.product-details {
  padding: 0 0 0 24px;
  position: relative;
}
div.product-details > .title {
  color: #333695;
  font-weight: 900;
  margin-bottom: 12px;
}
div.product-details > .notes {
  font-style: italic;
  margin-bottom: 12px;
}
div.product-details > .price {
  font-weight: 500;
  position: absolute;
  bottom: 0;
}
</style>
