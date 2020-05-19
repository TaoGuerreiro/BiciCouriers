
// const simulation = () => {
//   document.addEventListener("turbolinks:load", (event) => {
//     const volumes = document.querySelectorAll('.volume');

//     const urgences = document.querySelectorAll('.urgence');
//     const urgenceInput = document.getElementById('simulation_s_urgence');
//     const volumeInput = document.getElementById('simulation_s_volume');
//     const distanceInput = document.getElementById('simulation_s_distance');
//     const mainUrgence = document.getElementById('urgence');
//     const mainVolume = document.getElementById('volume');
//     let urgenceTickets = 0
//     let volumeTickets = 0
//     let distanceTickets = 0
//     let sum = 0

//     const total = () => {
//     urgenceTickets = parseInt(mainUrgence.dataset.urgence, 10);
//     volumeTickets = parseInt(mainVolume.dataset.volume, 10);
//     sum = urgenceTickets + volumeTickets + distanceTickets
//     console.log(sum)
//     }

//     const removeActive = (array) => {
//         array.forEach((urgence) => {
//           urgence.classList.remove('active');
//         });
//       }

//     urgences.forEach( (urgence) => {
//       urgence.addEventListener('click', (event) => {
//         removeActive(urgences);
//         urgence.classList.add('active');
//         // console.log(urgence);
//         const ticket = urgence.dataset.tickets;
//         // console.log(ticket);
//         mainUrgence.dataset.urgence = parseInt(ticket, 10);
//         urgenceInput.value = parseInt(ticket, 10);
//         total();
//       });
//     });

//     volumes.forEach( (volume) => {
//       volume.addEventListener('click', (event) => {
//         removeActive(volumes);
//         volume.classList.add('active');
//         // console.log(volume);
//         const ticket = volume.dataset.tickets;
//         // console.log(ticket);
//         mainVolume.dataset.volume = parseInt(ticket, 10);
//         volumeInput.value = parseInt(ticket, 10);
//         total();
//       });
//     });

//     const directionsService = new google.maps.DirectionsService();
//     const directionsDisplay = new google.maps.DirectionsRenderer();
//     const pickupInput = document.getElementById('simulation_s_pickup');
//     const dropInput = document.getElementById('simulation_s_drop');

//     const calculDistance = () => {
//       let distance = 0
//       const request = {
//         origin: pickupInput.value,
//         destination: dropInput.value,
//         travelMode: google.maps.DirectionsTravelMode.WALKING
//       };
//       directionsService.route(request, function(response, status) {
//        if (status == google.maps.DirectionsStatus.OK) {
//         distance = response.routes[0].legs[0].distance.value;
//         directionsDisplay.setDirections(response);
//         distanceTickets = Math.ceil(distance / 3500)
//         }
//       });
//     }


//     pickupInput.addEventListener('change', () => {
//       setTimeout(calculDistance, 500);
//       total();
//     });
//     dropInput.addEventListener('change', () => {
//       setTimeout(calculDistance, 500);
//       total();
//     });
//   });
// }

// export { simulation }

