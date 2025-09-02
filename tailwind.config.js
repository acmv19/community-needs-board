/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',   // todas tus vistas
    './app/helpers/**/*.rb',       // helpers de Rails
    './app/javascript/**/*.js'     // si usas JS
  ],
  theme: {
    extend: {
      colors: {
        primary: '#1D4ED8',    // azul principal
        secondary: '#FBBF24',  // amarillo
        accent: '#10B981',     // verde
        graylight: '#F3F4F6',  // gris claro para fondos
        graydark: '#374151'    // gris oscuro para texto
      },
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui'],
        serif: ['Merriweather', 'ui-serif', 'Georgia']
      },
    },
  },
  plugins: [],
}
