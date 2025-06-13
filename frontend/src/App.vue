<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import HelloWorld from './components/HelloWorld.vue'
</script>
<template>
  <div id="app-old">
    <h1>IRIS Coffee Company</h1>
    <strong>Current route path:</strong> {{ $route.fullPath }}
    <nav>
      <RouterLink to="/">Home</RouterLink> |
      <RouterLink to="/sale">Last chance</RouterLink> |
      <RouterLink to="/about">About</RouterLink>
    </nav>
      <RouterView/>
  </div>
</template>

<style scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin: 48px 124px;
}

h1 {
  margin: 0;
  text-align: center;
}

#nav {
  padding: 10px 0 20px 0;
  text-align: center;
}

#nav a {
  font-weight: bold;
  color: #333695;
}

#nav a.router-link-exact-active {
  color: #42b983;
}

.warning {
  text-align: center;
}

.about {
  max-width: 800px;
}
</style>
