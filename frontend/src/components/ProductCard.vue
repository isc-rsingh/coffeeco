<template>
  <li class="product-card">
    <img :src="'/' + product.img">
    <div class="product-details">
      <div class="title">{{product.product_code}}</div>
      <div class="notes">{{product.roasting_notes}}</div>
      <div class="roasted">Roasted on: {{product.time_roasted | moment}}</div>
      <div class="price-order">
        <div class="order">
          <form @submit.prevent="processOrder">
          <input type="number" name="q" min=1 :max=product.quantity v-model=orderquantity>
          <button type="submit">Place Order</button>
          </form>
        </div>
        <div class="price">Price per bag: <span class="pricenum">{{product.price}}</span></div>
      </div>
    </div>
  </li>
</template>

<script>
import axios from 'axios';
import moment from 'moment';

export default {
  name: 'ProductCard',
  props: ['product'],
  data() {
    return {
      orderquantity: 1,
      price: this.product.price,
      catalog_id: this.product.catalog_id,
    };
  },
  filters: {
    moment(date) {
      return moment(date).format('MMMM Do');
    },
  },
  methods: {
    processOrder() {
      const nm = this.product.product_code;
      const ci = this.product.catalog_id;
      const oq = this.orderquantity;
      // console.log({ catalog_id: this.catalog_id, quant: this.orderquantity, price: this.price });
      const orderurl = `http://localhost:52773/api/coffeeco/catalog/sellproduct/${ci}/${oq}`;
      axios
        .post(orderurl)
        .then(
          (response) => alert(`Ordered ${oq} bags of ${nm}!\n${response.data.quantity} still in stock.`),
        );
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
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
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
.price-order {
  display: inline;
}
.order {
  float: right;
}
</style>
