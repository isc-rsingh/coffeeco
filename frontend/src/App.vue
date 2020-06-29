<template>
  <div id="app">
    <h1>IRIS Coffee Company</h1>
    <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/sale">Last chance</router-link> |
      <router-link to="/about">About</router-link>
    </div>
    <router-view/>
  </div>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
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
</style>
