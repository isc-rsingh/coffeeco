<template>
  <div class="home">
    <ul v-if="loading">
      <product-card-skeleton v-for="n in 3" :key="n" />
    </ul>
    <h2 class="warning" v-else-if="products.length === 0">
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
import ProductCardSkeleton from '@/components/ProductCardSkeleton.vue';

export default {
  name: 'Home',
  components: {
    ProductCard,
    ProductCardSkeleton,
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
        url: 'api/coffeeco/catalog/getproducts/1',
        params: {
          format: 'json',
        },
      });
    },
  },
};
</script>

<style>
.warning{
  text-align: center;
}
</style>
