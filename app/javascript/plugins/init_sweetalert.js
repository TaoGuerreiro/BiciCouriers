import swal from 'sweetalert2'
import  { simulation } from '../shared/simulation.js';

const initSweetalert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {

    swal.fire(options).then(callback); // <-- add the `.then(callback)`
    });
  }
};



const initBicialert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {

    swal.fire(options).then(callback); // <-- add the `.then(callback)`
    });
  }
};

export { initSweetalert };
