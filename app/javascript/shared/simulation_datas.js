import  { initSweetalert } from '../plugins/init_sweetalert.js';
import { total } from '../shared/simulation.js';
import swal from 'sweetalert2'



let sum = null
let call_data = []
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
    html:
    `<p class='text-white'> Cette course pour ${price * sum / 100} € soit ${sum} ticket(s) pour les abonné·e·s !</p>` +
    `<button id="pay" class="btn btn-primary hidden">Pay</button>`,
    footer: '<a href="/tarifs">Toute nos offres</a>',
    showCloseButton: true,
    showCancelButton: true,
    confirmButtonText:
      `Commander pour ${price * sum / 100}€`,
    confirmButtonAriaLabel: 'Thumbs up, great!',
    cancelButtonText:
      'Se faire rappeler',
    cancelButtonAriaLabel: 'rappel',
    reverseButtons: true,

  }, (result) => {
    if (result.value) {
      const link = document.querySelector('#purchase-link');
      link.click();
          swal.fire(
            {
            buttonsStyling: false,
            customClass: {
              confirmButton: 'bici-button',
              cancelButton: 'bici-button',
            },
            background: '#FF016C',
            title: "Quelques infos suplémentaire:",
            inputPlaceholder: "Nom, téléphone, interphone, petits détails qui rendent un coursier heureux !",
            input: 'textarea',
            inputValidator: (value) => {
              if (!value) {
                return 'You need to write something!'
              }
            }
          }).then((details) => {
            if (details.value) {
            const detailsInput = document.getElementById('simulation_details');
            detailsInput.value = details.value
              const link = document.querySelector('#pay');
              link.click();
            } else {
              return
            }
          });

    } else if (
    result.dismiss === swal.DismissReason.cancel
    ) {
            swal.fire({
              buttonsStyling: false,
              customClass: {
                confirmButton: 'bici-button',
                cancelButton: 'bici-button',
              },
              background: '#FF016C',
              title: "Quelques infos :",
              input: 'tel',
              inputPlaceholder: 'Téléphone',
              inputValidator: (value) => {
                if (!value) {
                  return 'You need to write something!'
                }
              }
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
                    inputValidator: (value) => {
                      if (!value) {
                        return 'You need to write something!'
                      }
                    }
              }).then((name) => {
                const nameInput = document.getElementById('simulation_name');
                const puInput = document.getElementById('simulation_s_pickup');
                const drInput = document.getElementById('simulation_s_drop');
                const diInput = document.getElementById('simulation_s_distance');
                const voInput = document.getElementById('simulation_s_volume');
                const urInput = document.getElementById('simulation_s_urgence');
                nameInput.value = name.value

//recup les donné des input du formulaire et les calé dans un JSON

              let myData = {
                    "phone" : phone_number.value,
                    "email" : 'florent@gmail.com',
                    "name" : name.value,
                    "message" : `Une demande de livraison entre ${puInput.value} et ${drInput.value}. Urgence : ${urInput.value}. Volume : ${voInput.value}. Distance : ${diInput.value}`
                  }
                  call_data.push( myData )
                  document.getElementById('data-spot').value = JSON.stringify(call_data);

              swal.fire({
                background: '#FF016C',
                position: 'top',
                icon: 'success',
                title: 'On vous rappel rapidement !',
                showConfirmButton: false,
                timer: 2500
                  });
              const link1 = document.querySelector('#mail-link');
              link1.click();
                });
              });
    }
  });
}

export  { datas }

