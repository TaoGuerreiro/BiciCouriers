import  { counter } from '../shared/counter.js';
import  { sum } from '../shared/slider.js';

let urgenceTickets = 0
let urgenceRange = 11
const urgenceToggle = () => {
  document.addEventListener("turbolinks:load", (event) => {
  urgenceTickets = 0
  const urgence1 = document.querySelector('.urgence-1');
  const urgence2 = document.querySelector('.urgence-2');
  const urgence3 = document.querySelector('.urgence-3');
  const urgence4 = document.querySelector('.urgence-4');
  if (urgence4 === null) {
    return
  }

  const resetUrgence = () => {
  const urgences = document.querySelectorAll('.urgence');
    urgences.forEach((urg) => {
      urg.classList.remove('active');
    });
  }
  const totalContainer = document.querySelector('.total-container')
  const price = totalContainer.dataset.carnetPrice;

  urgence1.addEventListener('click', (event) => {
    resetUrgence();
    urgence1.classList.add('active');
    const urgenceDiv = document.getElementById('urgence-t');
    const urgenceDivPrice = document.getElementById('urgence-e');
    const urgenceLinePrice = document.querySelector('.total-urgence');
    urgenceLinePrice.classList.add('hidden');
    urgenceDiv.innerHTML = 0
    urgenceDivPrice.innerHTML = 'inclu'
    urgenceTickets = 0
    urgenceRange = 11
    counter();
  });

  urgence2.addEventListener('click', (event) => {
    resetUrgence();
    urgence2.classList.add('active');
    const urgenceDiv = document.getElementById('urgence-t');
    const urgenceDivPrice = document.getElementById('urgence-e');
    const urgenceLinePrice = document.querySelector('.total-urgence');
    urgenceLinePrice.classList.remove('hidden');
    urgenceDiv.innerHTML = 1
    urgenceDivPrice.innerHTML = `${(1 * price /100).toFixed(2)} €`
    urgenceTickets = 1
    urgenceRange = 4
    counter();
  });

  urgence3.addEventListener('click', (event) => {
    resetUrgence();
    urgence3.classList.add('active');
    const urgenceDiv = document.getElementById('urgence-t');
    const urgenceDivPrice = document.getElementById('urgence-e');
    const urgenceLinePrice = document.querySelector('.total-urgence');
    urgenceLinePrice.classList.remove('hidden');
    urgenceDiv.innerHTML = 2
    urgenceDivPrice.innerHTML = `${(2 * price /100).toFixed(2)} €`
    urgenceTickets = 2
    urgenceRange = 0.75
    counter();
  });

  urgence4.addEventListener('click', (event) => {
    resetUrgence();
    urgence4.classList.add('active');
    const urgenceLinePrice = document.querySelector('.total-urgence');
    urgenceLinePrice.classList.remove('hidden');
    // const urgenceDiv = document.getElementById('urgence-t');
    // const urgenceDivPrice = document.getElementById('urgence-e');
    // const urgenceLinePrice = document.querySelector('.total-urgence');
    // urgenceDiv.innerHTML = 2
    // urgenceDivPrice.innerHTML = `${(2 * price /100).toFixed(2)} €`
    urgenceTickets = 2

    // const bar1 = document.getElementById('myItem1').ldBar;
    // bar1.set(60);


    urgenceRange = 0.75
    counter();
  });
  });
}

export { urgenceToggle, urgenceTickets, urgenceRange };
