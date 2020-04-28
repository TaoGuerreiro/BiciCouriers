import  { initMap, distanceTickets } from '../shared/init_map.js';
import  { urgenceToggle, urgenceTickets } from '../shared/urgence.js';
import  { bikeToggle, volumeTickets } from '../shared/volume.js';

let price = 0



const counter = () => {
    let sum = 0
    const totalContainer = document.querySelector('.total-container')
    if (totalContainer === null) {
      return
    }
    price = totalContainer.dataset.carnetPrice;
  // Distance
  const ticketsDistanceInput = document.querySelector('.tickets-distance');
  ticketsDistanceInput.value = distanceTickets;
  console.log("distance" + distanceTickets);
  // Volume
  const ticketsVolumeInput = document.querySelector('.tickets-volume');
  ticketsVolumeInput.value = volumeTickets;
  console.log("volume" + volumeTickets);
  // Urgence
  const ticketsUrgenceInput = document.querySelector('.tickets-urgence');
  ticketsUrgenceInput.value = urgenceTickets;
  console.log("urgence" + urgenceTickets);

  // TOTAL
   sum = volumeTickets + urgenceTickets + distanceTickets
  console.log(sum);

  const totalDiv = document.getElementById('total-t');
  totalDiv.innerHTML = sum

  const totalDivPrice = document.getElementById('total-e');
  totalDivPrice.innerHTML = `${(sum * price / 100).toFixed(2)} €`;

  const ticketsFormInput = document.querySelector('.tickets-input');
  ticketsFormInput.value = sum;
}

export { counter, price }
