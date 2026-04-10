/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#1D4ED8", // dark blue (navbar)
        secondary: "#60A5FA", // light blue (cards)
        accent: "#FACC15", // gold/yellow (buttons/hover)
        danger: "#EF4444", // red (delete buttons)
      },
    },
  },
  plugins: [],
};
