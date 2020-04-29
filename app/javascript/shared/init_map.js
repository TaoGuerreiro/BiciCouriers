import  { counter } from '../shared/counter.js';

let distanceTickets = 0
const initMap = () => {


  document.addEventListener("turbolinks:load", () => {
    distanceTickets = 0
    // addresses input
    const pickupInput = document.getElementById('course_pickups_attributes_0_address');
    const dropInput = document.getElementById('course_drops_attributes_0_address');
    if (pickupInput === null) {
      return
    }

    // favorites dropdown
    const pickupFavInput = document.getElementById('favorite-pickup');
    const dropFavInput = document.getElementById('favorite-drop');

    const totalContainer = document.querySelector('.total-container');
    const price = totalContainer.dataset.carnetPrice;

    counter();
    const directionsService = new google.maps.DirectionsService();
    const directionsDisplay = new google.maps.DirectionsRenderer();
    const nantes = {lat: 47.2173, lng: -1.5534};
    const myOptions = {
      zoom:13,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      center: nantes
    }
    const map = new google.maps.Map(document.getElementById("map-container"), myOptions);
    if (map === null) {
      return
    }
    directionsDisplay.setMap(map);

        const calculDistance = () => {
          let distance = 0
          const request = {
            origin: pickupInput.value,
            destination: dropInput.value,
            travelMode: google.maps.DirectionsTravelMode.WALKING
          };
          directionsService.route(request, function(response, status) {
           if (status == google.maps.DirectionsStatus.OK) {
            distance = response.routes[0].legs[0].distance.value;
            directionsDisplay.setDirections(response);
            distanceTickets = Math.ceil(distance / 3500)
            // console.log(distanceTickets);
            const distanceDiv = document.getElementById('distance-t');
            const distanceDivPrice = document.getElementById('distance-e');
            distanceDiv.innerHTML = distanceTickets
            // console.log(distanceDivPrice);
            distanceDivPrice.innerHTML = `${(distanceTickets * price /100).toFixed(2)} €`
            const distanceFormInput = document.querySelector('.distance-input');
            distanceFormInput.value = distance;
            counter();
            }
          });
        }
      pickupInput.addEventListener('change', calculDistance );
      dropInput.addEventListener('change', calculDistance );

      pickupFavInput.addEventListener('change', () => {
        setTimeout(calculDistance, 500);
      });
      dropFavInput.addEventListener('change', () => {
        setTimeout(calculDistance, 500);
      });
  });
}


export { initMap, distanceTickets };
