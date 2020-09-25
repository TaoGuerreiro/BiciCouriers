const addValidationError = (addressValidator, urgenceValidator) => {
  switch (true) {
    case (addressValidator[0].value == "") :
      addressValidator[0].style.boxShadow = "0 0 5px 1px #55b5ed";
      throw new Error("Il manque des infos !");
      break;
    case (addressValidator[1].value == "") :
      addressValidator[1].style.boxShadow = "0 0 5px 1px #55b5ed";
      throw new Error("Il manque des infos !");
      break;
    case (!urgenceValidator[0].classList.contains("active") && !urgenceValidator[1].classList.contains("active") && !urgenceValidator[2].classList.contains("active")):
      urgenceValidator.forEach((urgence) => {
        urgence.style.boxShadow = "0 0 5px 1px #55b5ed";
      });
      throw new Error("Il manque des infos !");
      break;
  }
}



const removeValidationError = (address_inputs, urgence_inputs) => {
  address_inputs.forEach((input) => {
    input.addEventListener('input', (event) => {
      if (input.value != "") {
        input.style.boxShadow = "none";
      }
    });
  });

  urgence_inputs.forEach((input) => {
    input.addEventListener('click', (event) => {
      urgence_inputs.forEach((input) => {
        input.style.boxShadow = "none";
      });
    });
  });
}

export { removeValidationError, addValidationError }
