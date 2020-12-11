const addValidationError = (addressValidator, urgenceValidator, volumeValidator) => {
//       if (addressValidator == null) {
//       return
//     }

//   switch (true) {
//     case (addressValidator[0].value == "") :
//       addressValidator[0].style.boxShadow = "0 0 5px 1px #000000";
//       throw new Error("Il manque des infos !");
//       break;
//     case (addressValidator[1].value == "") :
//       addressValidator[1].style.boxShadow = "0 0 5px 1px #000000";
//       throw new Error("Il manque des infos !");
//       break;
//     case (!urgenceValidator[0].classList.contains("active") && !urgenceValidator[1].classList.contains("active") && !urgenceValidator[2].classList.contains("active")):
//       urgenceValidator.forEach((urgence) => {
//         urgence.style.boxShadow = "0 0 5px 1px #000000";
//       });
//       throw new Error("Il manque l'urgence !");
//       break;
//     case (!volumeValidator[0].classList.contains("active") && !volumeValidator[1].classList.contains("active")):
//       volumeValidator.forEach((urgence) => {
//         urgence.style.boxShadow = "0 0 5px 1px #000000";
//       });
//       throw new Error("Il manque le volume !");
//       break;
//   }
}

const removeValidationError = (address_inputs, urgence_inputs, volume_inputs) => {
//     if (address_inputs == null) {
//       return
//     }

//   address_inputs.forEach((input) => {
//     input.addEventListener('input', (event) => {
//       if (input.value != "") {
//         input.style.boxShadow = "none";
//       }
//     });
//   });

//   urgence_inputs.forEach((input) => {
//     input.addEventListener('click', (event) => {
//       urgence_inputs.forEach((input) => {
//         input.style.boxShadow = "none";
//       });
//     });
//   });

//   volume_inputs.forEach((input) => {
//     input.addEventListener('click', (event) => {
//       volume_inputs.forEach((input) => {
//         input.style.boxShadow = "none";
//       });
//     });
//   });
}

export { removeValidationError, addValidationError }
