import  { datas } from '../shared/simulation_datas.js';

const simulation = () => {
  document.addEventListener("turbolinks:load", (event) => {
    const volumes = document.querySelectorAll('.volume');

    const urgences = document.querySelectorAll('.urgence');

    const urgenceInput = document.getElementById('simulation_s_urgence');
    const volumeInput = document.getElementById('simulation_s_volume');
    const distanceInput = document.getElementById('simulation_s_distance');

    const mainUrgence = document.getElementById('urgence');
    const mainVolume = document.getElementById('volume');
    const mainDistance = document.getElementById('distance');

    let urgenceTickets = 0
    let volumeTickets = 0
    let distanceTickets = 0



    const removeActive = (array) => {
        array.forEach((urgence) => {
          urgence.classList.remove('active');
        });
      }

    urgences.forEach( (urgence) => {
      urgence.addEventListener('click', (event) => {
        removeActive(urgences);
        urgence.classList.add('active');
        // console.log(urgence);
        const ticket = urgence.dataset.tickets;
        // console.log(ticket);
        mainUrgence.dataset.urgence = parseInt(ticket, 10);
        urgenceInput.value = parseInt(ticket, 10);
        datas(700);
      });
    });

    volumes.forEach( (volume) => {
      volume.addEventListener('click', (event) => {
        removeActive(volumes);
        volume.classList.add('active');
        // console.log(volume);
        const ticket = volume.dataset.tickets;
        // console.log(ticket);
        mainVolume.dataset.volume = parseInt(ticket, 10);
        volumeInput.value = parseInt(ticket, 10);
        datas(700);
      });
    });

    const directionsService = new google.maps.DirectionsService();
    const directionsDisplay = new google.maps.DirectionsRenderer();
    const pickupInput = document.getElementById('simulation_s_pickup');
    const dropInput = document.getElementById('simulation_s_drop');

    const calculDistance = () => {
      if (dropInput.value.length == 0 || pickupInput.value.length == 0 )
      {
        return
      }
      let distance = 0
      const request = {
        origin: pickupInput.value,
        destination: dropInput.value,
        travelMode: google.maps.DirectionsTravelMode.WALKING
      };
      directionsService.route(request, function(response, status) {
       if (status == google.maps.DirectionsStatus.OK) {
        distance = response.routes[0].legs[0].distance.value;
        // console.log(distance)
        directionsDisplay.setDirections(response);
        mainDistance.dataset.distance = parseInt(Math.ceil(distance / 3500), 10);
        volumeInput.input = parseInt(Math.ceil(distance / 3500), 10);
        datas(700);
        }
      });
    }


    pickupInput.addEventListener('keyup', () => {
      setTimeout(calculDistance, 400);
    });
    dropInput.addEventListener('keyup', () => {
      setTimeout(calculDistance, 400);
    });
  });
}

const total = () => {
    const mainUrgence = document.getElementById('urgence');
    const mainVolume = document.getElementById('volume');
    const mainDistance = document.getElementById('distance');
    const priceInput = document.getElementById('simulation_price_cents');
    let urgenceTickets = parseInt(mainUrgence.dataset.urgence, 10);
    let volumeTickets = parseInt(mainVolume.dataset.volume, 10);
    let distanceTickets = parseInt(mainDistance.dataset.distance, 10);
    let sum = parseInt((urgenceTickets + volumeTickets + distanceTickets), 10);
    priceInput.value = sum * 700
    return sum
  }

export { simulation, total }

