module.exports = {
    purge: [],
    darkMode: false, // or 'media' or 'class'
    theme: {
      extend: {
        colors: {
          'blue-bici': '#153A7E',
          'pink-bici': '#FF016C',
          'yellow-bici': '#FFCC00',
        },
      },
    },
    variants: {
      extend: {
        borderStyle: ['hover', 'focus'],
        fontWeight: ['hover', 'focus']
      },
    },
    plugins: [],
  }