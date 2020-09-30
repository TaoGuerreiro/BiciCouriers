import  { initGuestAlert } from '../plugins/init_sweetalert.js';
import swal from 'sweetalert2'

const sweetalert_display = (addressValidator, urgenceValidator, volumeValidator) => {

  initGuestAlert(addressValidator, urgenceValidator, volumeValidator, '#continue',{
    buttonsStyling: false,
    customClass: {
      confirmButton: 'bici-button mar10'
    },
    title: `<p class='text-white'> Des infos à nous donner ?</p>`,
    background: '#FF016C',
    position: 'top',
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
      } else if (value.length < 3 ) {
        return "C'est pas grand chose comme infos 😇​"
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
            return "Pas d'anonyme chez nous 😀​" }
          else if (!/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(value)) {
            return "cet email n'est pas valide 🤔​"
          }
        }
      }).then((mail) => {

        if (mail.value) {
          const emailInput = document.getElementById('course_user_email')
          emailInput.value = mail.value
          swal.fire(
          {
            buttonsStyling: false,
            customClass: {
              confirmButton: 'sw-button-user',
              denyButton: 'bici-button sw-button-stripe',
            },
            background: '#FF016C',
            title: "Comment souhaitez vous regler la course ?",
            reverseButtons: true,
            showDenyButton: true,
            confirmButtonText: `Déjà client·e ? / Payer à la livraison`,
            denyButtonText: `Payer en ligne`,
          }).then((payement) => {

            if (payement.value) {
              const link = document.getElementById('save-course');
              link.click();
              swal.fire({
                background: '#FF016C',
                icon: 'success',
                title: 'Bien reçu ! 😎​',
                showConfirmButton: false,
                timer: 1500
              })
          } else if (payement.isDenied) {
              const stripeCheckbox = document.getElementById('stripe');
              stripeCheckbox.click()
              const link = document.getElementById('save-course');
              link.click()

              swal.fire({
                background: '#FF016C',
                icon: 'success',
                title: 'Bien reçu ! 😎​',
                showConfirmButton: false
              })
            return
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

export  { sweetalert_display }

