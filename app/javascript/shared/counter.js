import  { initMap, distanceTickets } from '../shared/init_map.js';
import  { urgenceToggle, urgenceTickets } from '../shared/urgence.js';
import  { urgenceTicketsSurMesure } from '../shared/slider.js';
import  { bikeToggle, volumeTickets } from '../shared/volume.js';

let price = 0



const counter = () => {
    let sum = 0
    // console.log("slider" + urgenceTicketsSurMesure)
    // console.log("button" + urgenceTickets)
    const trueUrgenceTickets = Math.max.apply(null,[urgenceTicketsSurMesure, urgenceTickets]);
    const totalContainer = document.querySelector('.total-container')
    if (totalContainer === null) {
      return
    }
  price = totalContainer.dataset.carnetPrice;
  // Distance
  const ticketsDistanceInput = document.querySelector('.tickets-distance');
  ticketsDistanceInput.value = distanceTickets;
  // console.log("distance" + distanceTickets);
  // Volume
  const ticketsVolumeInput = document.querySelector('.tickets-volume');
  ticketsVolumeInput.value = volumeTickets;
  // console.log("volume" + volumeTickets);

  // Urgence
  const urgenceDivPrice = document.getElementById('urgence-e');
  urgenceDivPrice.innerHTML = `${(trueUrgenceTickets * price /100).toFixed(2)} €`
  console.log(urgenceDivPrice);
  console.log(`${(trueUrgenceTickets * price /100).toFixed(2)} €`);

  const urgenceDiv = document.getElementById('urgence-t');
  urgenceDiv.innerHTML = trueUrgenceTickets;

  const ticketsUrgenceInput = document.querySelector('.tickets-urgence');
  ticketsUrgenceInput.value = trueUrgenceTickets;


  // TOTAL
   sum = volumeTickets + trueUrgenceTickets + distanceTickets
  // console.log(sum);

  const totalDiv = document.getElementById('total-t');
  totalDiv.innerHTML = sum

  const totalDivBestPrice = document.getElementById('best-price');
  const totalDivPrice = document.getElementById('total-e');
  if ( totalDivBestPrice == undefined) {
    totalDivPrice.innerHTML = `${(sum * price / 100).toFixed(2)} €`;
  } else {
    totalDivBestPrice.innerHTML = `${(sum * 420 / 100).toFixed(2)} €`;
    totalDivPrice.innerHTML = `${(sum * price / 100).toFixed(2)} €`;
  }

  const ticketsFormInput = document.querySelector('.tickets-input');
  ticketsFormInput.value = sum;
}

export { counter, price }
