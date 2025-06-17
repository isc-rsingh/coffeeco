<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>
<template>
  <div id="app">
    <header>
      <h1>IRIS Coffee Company</h1>
      <nav>
        <RouterLink to="/" class="nav-link">Home</RouterLink>
        <RouterLink to="/sale" class="nav-link">Last Chance</RouterLink>
        <RouterLink to="/about" class="nav-link">About</RouterLink>
      </nav>
    </header>
    <main>
      <RouterView/>
    </main>
    <footer>
      <div class="footer">
        <p>Powered By InterSystem IRIS</p>
      </div>
    </footer>
  </div>
</template>

<style scoped>
html, body, #app {
  height: 100%;
  margin: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: var(--vt-c-text-light-1);
  background: var(--color-background);
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

#app {
  width: 100vw;
  height: 100vh;
  box-sizing: border-box;
}

header {
  background-color: var(--vt-c-indigo);
  padding: 12px 24px;
  text-align: center;
  color: var(--vt-c-white);
  box-shadow: 0 2px 6px rgb(0 0 0 / 0.15);
  flex-shrink: 0;
  display: flex;
  justify-content: space-between;
}

h1 {
  margin: 0;
  font-weight: 700;
  font-size: 2.4rem;
  font-family: 'Georgia', serif;
  text-shadow: 1px 1px 2px rgba(0,0,0,0.15);
}

nav {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 24px;
}

.nav-link {
  font-weight: 600;
  color: var(--vt-c-white-soft);
  text-decoration: none;
  padding: 6px 12px;
  border-radius: 4px;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.nav-link:hover {
  background-color: var(--vt-c-white-soft);
  color: var(--vt-c-indigo);
}

.nav-link.router-link-exact-active {
  background-color: var(--vt-c-white-soft);
  color: var(--vt-c-indigo);
}

main {
  flex-grow: 1;
  padding: 24px 40px;
  font-size: 1.1rem;
  color: var(--vt-c-text-light-2);
  overflow-y: auto;
}

.footer
{
  background: linear-gradient(135deg, #f1f5f9, #e2e8f0);
  border-top: 1px solid #cbd5e1;
  padding: 20px 0;
  text-align: center;
}

.footer p{
  color: #64748b;
  font-size: 1rem;
  font-weight: 500;
}

</style>
