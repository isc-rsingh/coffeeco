<template>
  <div class="home">
    <p v-if="loading">
      Loading...
    </p>
    <h2 class="warning" v-if="products.length == 0">
      No fresh products right now.
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
  name: 'Home',
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
        this.products = response.data.products;
        this.loading = false;
      });
  },
  methods: {
    fetchProducts() {
      return axios({
        method: 'get',
        url: 'http://localhost:52773/api/coffeeco/catalog/getproducts/1',
        params: {
          format: 'json',
        },
      });
    },
  },
};
</script>
