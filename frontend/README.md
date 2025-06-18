# Frontend

This directory contains the frontend part of the IRIS Fullstack demo application, built using Vue 3, Vite, and TypeScript.

## Overview

The frontend is a Single Page Application (SPA) built with Vue 3. It uses Vite as the build tool and development server for fast hot-reloading and optimized builds. TypeScript is used for type safety and improved developer experience.

### Key Files

- `src/main.ts` - The entry point of the application. It imports global styles, creates the Vue app instance, sets up the Vue Router, and mounts the app to the DOM element with id `app`.
- `src/App.vue` - The root Vue component that defines the main layout of the app. It includes the header with navigation links, a footer, and a `<router-view>` where the matched page components are rendered.
- `src/router/index.ts` - Configures Vue Router with routes mapping URL paths to Vue components in the `views/` directory. It uses history mode for navigation without page reloads.

### Folder Structure

- `src/views/` - Contains page-level Vue components representing different pages of the app:
  - `About.vue` - The About page with static information about the app.
  - `Home.vue` - The landing page that fetches and displays a list of products. It uses axios to call the backend API and shows loading placeholders while data is fetched.
  - `Sale.vue` - The sale page view (structure similar to Home.vue).
- `src/components/` - Contains reusable Vue components used across pages:
  - `ProductCard.vue` - Displays detailed information about a product, including image, roasting notes, price, and an order form. It uses axios to post orders to the backend.
  - `ProductCardSkeleton.vue` - A placeholder component shown while product data is loading, improving perceived performance.
- `src/assets/` - Contains CSS stylesheets used globally or by components.
- `public/` - Contains static files such as images and logos that are served directly by the development server or in production.

## Project Setup

```sh
`npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

## Notes for Developers New to Vue

- Vue uses Single File Components (`.vue` files) that encapsulate template (HTML), script (JavaScript/TypeScript), and style (CSS) in one file for modularity and ease of maintenance.
- The app is reactive: changes to component data automatically update the UI without manual DOM manipulation.
- Routing is handled by Vue Router, which dynamically loads and displays page components based on the current URL path.
- Components are reusable building blocks that can be nested and composed to build complex user interfaces.
- Axios is used for HTTP requests to interact with the backend API for fetching product data and submitting orders.
