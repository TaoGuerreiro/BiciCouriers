import  { initGuestAlert } from '../plugins/init_sweetalert.js';
import { fetchWithToken } from "../utils/fetch_with_token";
import swal from 'sweetalert2'
const datas = () => {



const getCheckoutId = (mail) => {
  new Promise(() => {
    let data = { request: {mail:mail}}

      fetchWithToken("/course/checkout", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
      })
      .then(response => response.json())
      .then((data) => {
        // return data
      });
  });
}
//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST

// const promise1 = new Promise((resolve, reject) => {
//   setTimeout(() => {
//     resolve('foo');
//   }, 3000);
// });


// promise1.then((value) => {
//   console.log(value);
//   // expected output: "foo"
// });

// async function logCheckoutId (mail) {
//   await getCheckoutId(mail);
// };

const testbutton = document.getElementById('mailtest');

testbutton.addEventListener('click', (event) => {
  const mail = document.getElementById('course_user_email')
  event.preventDefault();
  getCheckoutId(mail.value);
});

//TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST

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
          const emailInput = document.getElementById('course_user_email')
          emailInput.value = mail.value
          swal.fire(
          {
            buttonsStyling: false,
            customClass: {
              confirmButton: 'sw-button-user',
              cancelButton: 'bici-button sw-button-stripe'
            },
            background: '#FF016C',
            title: "Comment souhaitez vous regler la course ?",
            // html:
            //   `<p class='text-white'> Réglement</p>`,

            reverseButtons: true,
            showCancelButton: true,
            confirmButtonText: `Déjà client·e ? / Payer à la livraison`,
            cancelButtonText: `Payer en ligne`

          }).then((payement) => {

            if (payement.value) {
              const link = document.getElementById('save-course');
              link.click();
              swal.fire({
                // position: 'top-end',
                background: '#FF016C',
                icon: 'success',
                title: 'Bien reçu ! 😎​',
                showConfirmButton: false,
                timer: 1500
              })
          } else {
              const stripeCheckbox = document.getElementById('stripe');
              const link = document.getElementById('save-course');

              stripeCheckbox.click()
              link.click()

              swal.fire({
                // position: 'top-end',
                background: '#FF016C',
                icon: 'success',
                title: 'Bien reçu ! 😎​',
                showConfirmButton: false,
                timer: 3000
              }).then(() =>{


                const mail = document.getElementById('course_user_email')
                console.log(mail.value); //-> ok
                getCheckoutId(mail.value).then((id) =>{
                  console.log(id)

                // stripeCheckbox.innerHTML = id
                }).catch(console.log('test'));
                const linkStripe = document.getElementById('pay');
                linkStripe.click()

              });
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

