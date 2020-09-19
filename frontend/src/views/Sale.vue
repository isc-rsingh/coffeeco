/* eslint-disable no-param-reassign */
<template>
  <div class="home">
    <p v-if="loading">
      Loading...
    </p>
    <h2 class="warning" v-if="products.length == 0">
      No sale products right now.
    </h2>
    <ul v-else>
      <product-card
        v-for="product in products"
        :key="product.catalog_id"
        :product='product' />
    </ul>
  </div>
</template>

<script>
import axios from 'axios';
import ProductCard from '@/components/ProductCard.vue';

export default {
  name: 'Sale',
  components: {
    ProductCard,
  },
  data() {
    return {
      loading: false,
      products: [],
    };
  },
  created() {
    this.loading = true;
    this.fetchProducts()
      .then((response) => {
        const newprods = [];
        response.data.products.forEach((prod) => {
          const newprod = prod;
          newprod.price -= 3;
          newprods.push(newprod);
        });
        this.products = newprods;
        this.loading = false;
      });
  },
  methods: {
    fetchProducts() {
      return axios({
        method: 'get',
        url: 'http://localhost:52773/api/coffeeco/catalog/getproducts/2',
        params: {
          format: 'json',
        },
      });
    },
  },
};
</script>

<style>
div.product-details .pricenum {
  color: red;
}
</style>
