module.exports = {
    purge: [],
    darkMode: false, // or 'media' or 'class'
    theme: {
      extend: {
        backgroundImage: theme => ({

          'bridge-image': "url('../../assets/images/story/story-image.png')",
          'bridge-large-image': "url('../../assets/images/velo-sur-pont-nantes.png')"
         }),
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
        fontWeight: ['hover', 'focus'],
        rotate: ['active', 'group-hover'],
        transform: ['group-hover'],
        transformOrigin: ['group-hover'],
      },
    },
    plugins: [],
  }