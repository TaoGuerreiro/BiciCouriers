import swal from 'sweetalert2'
import { addValidationError } from '../toggle/validations.js';


const initGuestAlert = (addressValidator = [], urgenceValidator = [], volumeValidator = [], selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {
      addValidationError(addressValidator, urgenceValidator, volumeValidator);
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
