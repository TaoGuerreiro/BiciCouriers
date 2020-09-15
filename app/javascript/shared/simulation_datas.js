import  { initGuestAlert } from '../plugins/init_sweetalert.js';
import swal from 'sweetalert2'
const datas = () => {



  console.log("oui")
  initGuestAlert('#continue',{
    buttonsStyling: false,
    customClass: {
      confirmButton: 'bici-button mar10'
    },
    title: `<p class='text-white'> Des infos à nous donner ?</p>`,
    background: '#FF016C',
    position: 'top',
    html:
    `<p class='text-white'> Livraison entre "addressePU" et "addresseDR" aujourd'hui avant "heure" !</p>` +
    `<button id="pay" class="btn btn-primary hidden">Pay</button>`,
    inputPlaceholder: "Nom, téléphone, interphone, petits détails qui rendent un coursier heureux !",
    input: 'textarea',
    showCloseButton: true,
    showCancelButton: false,
    confirmButtonText:
    `Suivant`,
    confirmButtonAriaLabel: 'Thumbs up, great!',
    reverseButtons: true,
    inputValidator: (value) => {
      if (!value) {
        return 'Même trois fois rien...'
      }
    }



  }, (result) => {
    if (result.value) {
      const detailsInput = document.getElementById('course_drops_attributes_0_details');
      detailsInput.value = result.value
      swal.fire(
      {
        buttonsStyling: false,
        customClass: {
          confirmButton: 'bici-button'
        },
        background: '#FF016C',
        title: "Un petit mail ?",
        inputPlaceholder: "NosClientsSontGéniaux@bicicouriers.fr",
        input: 'email',
        confirmButtonText:
        `Continuer`,
        showCancelButton: false,
        inputValidator: (value) => {
          if (!value) {
            return "Pas d'anonyme chez nous 😀​"
          }
        }
      }).then((mail) => {

        if (mail.value) {

          // const payementLivraisonButton = document.getElementById('payement-livraison');
          // console.log(payementLivraisonButton)
          // payementLivraisonButton.addEventListener('click', () => {
          //   const link = document.getElementById('save-course');
          //   link.click();
          // });


          console.log(mail.value)
          const emailInput = document.getElementById('course_user_email')
          emailInput.value = mail.value
          swal.fire(
          {
            buttonsStyling: false,
            customClass: {
              confirmButton: 'bici-button',
              cancelButton: 'bici-button',
              denyButton: 'bici-button',
            },
            background: '#FF016C',
            title: "Comment souhaitez vous regler la course ?",
            html:
              `<p class='text-white'> Réglement</p>` +
              `<button id="payemant-stripe" class="bici-button">Payer en ligne</button></br></br>` +
              `<button id="payement-livraison" class="bici-button">Payer à la livraison</button>`,
            reverseButtons: true,
            showCancelButton: false,
            confirmButtonText: `Déjà client·e ?`

          }).then((payement) => {

            if (payement.value) {
            // pay with stripe ?
            console.log("client")
            // const link = document.getElementById('save-course');
            link.click();
          } else {
            return
          }
        });
        } else {
          return
        }
      });
    } else {
      return
    }
  });
}

export  { datas }

