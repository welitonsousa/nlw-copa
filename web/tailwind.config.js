/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './**/*.tsx'
  ],
  theme: {
    extend: {
      backgroundImage: {
        app: 'url(/background.png)'
      },
      fontFamily: {
        sans: 'Roboto, sans-serif', 
      },
      colors: {
        grey: {
          900: '#121214',
          1000: '#8D8D99'
        }
      }
      
    },
  },
  plugins: [],
}
