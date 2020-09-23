import swal from 'sweetalert2'

const initGuestAlert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {
      //validations

    swal.fire(options).then(callback); // <-- add the `.then(callback)`
    });
  }
};



const initUserAlert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {

    swal.fire(options).then(callback); // <-- add the `.then(callback)`
    });
  }
};

export { initGuestAlert };
