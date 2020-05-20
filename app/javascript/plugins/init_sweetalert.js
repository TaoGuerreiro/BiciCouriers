import swal from 'sweetalert';
import  { simulation } from '../shared/simulation.js';

const initSweetalert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {

    swal(options).then(callback); // <-- add the `.then(callback)`
    });
  }
};

export { initSweetalert };
