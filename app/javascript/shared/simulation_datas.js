import  { initSweetalert } from '../plugins/init_sweetalert.js';
import { total } from '../shared/simulation.js';
import swal from 'sweetalert2'

let sum = null
const datas = (price) => {
  sum = total();
  initSweetalert('#sweet-alert-demo',{
    buttonsStyling: false,
    customClass: {
      confirmButton: 'bici-button mar10',
      cancelButton: 'bici-button mar10',
    },
    title: `<p class='text-white'> C'est parti !</p>`,
    background: '#FF016C',
    position: 'top',
    html: `<p class='text-white'> Cette course pour ${price * sum / 100} € soit ${sum} ticket(s) pour les abonné·e·s !</p>`,
    footer: '<a href="/tarifs">Toute nos offres</a>',
    showCloseButton: true,
    showCancelButton: true,
    confirmButtonText:
      `Commander pour ${price * sum / 100}€`,
    confirmButtonAriaLabel: 'Thumbs up, great!',
    cancelButtonText:
      'Se faire rappeler',
    cancelButtonAriaLabel: 'rappel'
  }, (result) => {
    if (result.value) {

          swal.fire(
            {
            buttonsStyling: false,
            customClass: {
              confirmButton: 'bici-button',
              cancelButton: 'bici-button',
            },
            background: '#FF016C',
            title: "Quelques infos suplémentaire:",
            input: 'textarea'
          }).then((details) => {
            const detailsInput = document.getElementById('simulation_details');
            detailsInput.value = details.value
                  // setTimeOut(() => {
                const link = document.querySelector('#submit-link');
                link.click();
                  // }, 2000);
              });
    } else {
            swal.fire({
              buttonsStyling: false,
              customClass: {
                confirmButton: 'bici-button',
                cancelButton: 'bici-button',
              },
              background: '#FF016C',
              title: "Quelques infos :",
              input: 'tel',
              inputPlaceholder: 'Téléphone'
            }).then((phone_number) => {
              const phoneInput = document.getElementById('simulation_phone');
              phoneInput.value = phone_number.value
              swal.fire({
                buttonsStyling: false,
                customClass: {
                  confirmButton: 'bici-button',
                  cancelButton: 'bici-button',
                },
                    background: '#FF016C',
                    title: "Quelque infos :",
                    input: 'text',
                    inputPlaceholder: 'Nom',
                    text: "Promis après c'est finis",
              }).then((name) => {
                const nameInput = document.getElementById('simulation_name');
                nameInput.value = name.value
              swal.fire({
                background: '#FF016C',
                position: 'top',
                icon: 'success',
                title: 'On vous rappel rapidement !',
                showConfirmButton: false,
                timer: 1500
                  });
              // const link1 = document.querySelector('#mail-link');
              // link1.click();
                });
              });
    }
  });
}

export  { datas }

