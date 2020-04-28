import  { counter } from '../shared/counter.js';

let volumeTickets = 0
const bikeToggle = () => {
  document.addEventListener("turbolinks:load", (event) => {
  volumeTickets = 0
  const bike1 = document.querySelector('.bike-1');
  const bike2 = document.querySelector('.bike-2');
  if (bike2 === null) {
    return
  }


  const resetBike = () => {
  const bikes = document.querySelectorAll('.bike');
    bikes.forEach((urg) => {
      urg.classList.remove('active');
    });
  }

  const totalContainer = document.querySelector('.total-container')
  const price = totalContainer.dataset.carnetPrice;

  bike1.addEventListener('click', (event) => {
    resetBike();
    bike1.classList.add('active');
    const cargoDiv = document.getElementById('cargo-t');
    const cargoDivPrice = document.getElementById('cargo-e');
    const urgenceLinePrice = document.querySelector('.total-cargo');
    urgenceLinePrice.classList.add('hidden');
    cargoDiv.innerHTML = 0
    cargoDivPrice.innerHTML = 0
    volumeTickets = 0
    const velo = document.querySelectorAll('.form-check');
    velo[0].firstChild.checked = true;
    counter();
  });

  bike2.addEventListener('click', (event) => {
    resetBike();
    bike2.classList.add('active');
    const cargoDiv = document.getElementById('cargo-t');
    const cargoDivPrice = document.getElementById('cargo-e');
    const urgenceLinePrice = document.querySelector('.total-cargo');
    urgenceLinePrice.classList.remove('hidden');
    cargoDiv.innerHTML = 1
    cargoDivPrice.innerHTML = `${(1 * price /100).toFixed(2)} €`
    volumeTickets = 1
    const cargo = document.querySelectorAll('.form-check');
    cargo[1].firstChild.checked = true;
    counter();
  });
  });
}

export { bikeToggle, volumeTickets };
