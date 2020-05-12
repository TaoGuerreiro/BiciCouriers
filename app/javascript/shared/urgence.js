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

  const unactiveUrgence = () => {
    const urgences = document.querySelectorAll('.urgence');
    urgences.forEach((urg) => {
      urg.classList.remove('active');
    });
    displayUrgenceLine();
  }

  const displayUrgenceLine = () => {
    const urgenceLinePrice = document.querySelector('.total-urgence');
    urgenceLinePrice.classList.remove('hidden');
  }

  urgence1.addEventListener('click', (event) => {
    unactiveUrgence();
    urgence1.classList.add('active');
    urgenceTickets = 0
    urgenceRange = 11
    counter();
  });

  urgence2.addEventListener('click', (event) => {
    unactiveUrgence();
    urgence2.classList.add('active');
    urgenceTickets = 1
    urgenceRange = 4
    counter();
  });

  urgence3.addEventListener('click', (event) => {
    unactiveUrgence();
    urgence3.classList.add('active');
    urgenceTickets = 2
    urgenceRange = 0.75
    counter();
  });

  urgence4.addEventListener('click', (event) => {
    unactiveUrgence();
    urgence4.classList.add('active');
    urgenceTickets = 0
    urgenceRange = 0.75
    counter();
  });
  });
}

export { urgenceToggle, urgenceTickets, urgenceRange };
