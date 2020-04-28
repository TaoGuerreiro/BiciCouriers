
const selectCarnet = () => {
  document.addEventListener("turbolinks:load", (event) => {
    const carnets = document.querySelectorAll('.carnet-card');

    const resetCarnet = () => {
      carnets.forEach((carnet) => {
        carnet.classList.remove('active');
      });
    }
    carnets.forEach((carnet) => {
      carnet.addEventListener('click', (event) => {
        resetCarnet();
        carnet.classList.add('active');
        const idCarnet = carnet.dataset.id;
        const carnetRadioButton = document.querySelectorAll('.form-check');
        carnetRadioButton[idCarnet].firstChild.checked = true;
      });
    });
  });
}


export { selectCarnet };
