import { defineConfig } from 'vitest/config';

// El navegador solicita /api al mismo origen; Vite reenvía a Spring Boot.
// Solo para desarrollo y comprobación local del build.
const proxy = { '/api': { target: 'http://127.0.0.1:8080', changeOrigin: true } };
export default defineConfig({
  base: './',
  server: { host: '127.0.0.1', port: 5173, strictPort: true, proxy },
  preview: { host: '127.0.0.1', port: 4173, strictPort: true, proxy },
  test: { environment: 'jsdom', setupFiles: './src/test-setup.js' }
});
