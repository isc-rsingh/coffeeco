<template>
  <li class="product-card-skeleton">
    <div class="image-placeholder"></div>
    <div class="details-placeholder">
      <div class="title-placeholder"></div>
      <div class="notes-placeholder"></div>
      <div class="roasted-placeholder"></div>
      <div class="price-order-placeholder">
        <div class="order-placeholder"></div>
        <div class="price-placeholder"></div>
      </div>
    </div>
  </li>
</template>

<script>
export default {
  name: 'ProductCardSkeleton',
};
</script>

<style scoped>
.product-card-skeleton {
  display: flex;
  margin: 24px 0;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
  animation: pulse 1.5s infinite ease-in-out;
}

.image-placeholder {
  width: 156px;
  height: 156px;
  background-color: #ddd;
  border-radius: 4px;
}

.details-placeholder {
  padding: 12px 12px 0 36px;
  flex: 1;
  margin: 12px 12px 0 0;
}

.title-placeholder,
.notes-placeholder,
.roasted-placeholder,
.price-placeholder,
.order-placeholder {
  background-color: #ddd;
  border-radius: 4px;
  margin-bottom: 12px;
}

.title-placeholder {
  width: 50%;
  height: 20px;
}

.notes-placeholder {
  width: 70%;
  height: 16px;
}

.roasted-placeholder {
  width: 40%;
  height: 16px;
}

.price-order-placeholder {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.price-placeholder {
  width: 30%;
  height: 20px;
}

.order-placeholder {
  width: 40%;
  height: 30px;
  border-radius: 6px;
}

@keyframes pulse {
  0% {
    background-color: #eee;
  }
  50% {
    background-color: #ddd;
  }
  100% {
    background-color: #eee;
  }
}
</style>