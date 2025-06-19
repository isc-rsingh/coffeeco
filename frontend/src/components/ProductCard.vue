<template>
  <li class="product-card">
    <img :src="'/' + product.img" alt="product image">
    <div class="product-details">
      <div class="title">{{product.product_code}}</div>
      <div class="notes">{{product.roasting_notes}}</div>
      <div class="roasted">Roasted on: {{ formatDate(product.time_roasted) }}</div>
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
  methods: {
    processOrder() {
      const nm = this.product.product_code;
      const ci = this.product.catalog_id;
      const oq = this.orderquantity;
      const orderurl = `api/coffeeco/catalog/sellproduct/${ci}/${oq}`;
      axios
        .post(orderurl)
        .then(
          (response) => {
            if (response.data.error) {
              alert(`${response.data.error}.`);
            } else {
              alert(`Ordered ${oq} bags of ${nm}!\n${response.data.quantity} still in stock.`);
            }
          },
        );
    },
    formatDate(date) {
      const m = moment(date);
      if (!m.isValid()) {
        console.warn('Invalid date passed to formatDate:', date);
        // placeholder
        return 'Freshly roasted';
      }
      return m.format('MMMM Do');
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
