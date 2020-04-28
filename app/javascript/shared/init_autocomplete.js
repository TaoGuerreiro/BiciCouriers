import places from 'places.js';

const initAutocomplete = () => {
  document.addEventListener("turbolinks:load", (event) => {
    const addressInput = document.querySelectorAll('.address-input')
    if (addressInput) {
      addressInput.forEach((input) => {
        places({
          container: input,
        });
      })
    }
  });
}

export { initAutocomplete };
