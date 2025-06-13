import { createMemoryHistory, createRouter } from 'vue-router';
// import Vue from 'vue';
// import VueRouter from 'vue-router';
import Home from '../views/Home.vue';
import Sale from '../views/Sale.vue';

// Vue.use(VueRouter);

const routes = [
];

const router = createRouter({
  // history: createMemoryHistory(import.meta.env.BASE_URL), 
  history: createMemoryHistory(), 
  routes: [
  { path: '/', name: 'Home', component: Home },
  { path: '/sale', name: 'Sale', component: Sale },
  { path: '/about', name: 'About', component: () => import('../views/About.vue'), },
  ]
});

export default router;
