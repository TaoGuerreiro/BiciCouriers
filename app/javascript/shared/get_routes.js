import { pickup, drop } from '../shared/get_long_lat.js';

const getRoutes = () => {
  document.addEventListener("turbolinks:load", (event) => {
    const mapElement = document.getElementById('map-container');
    const apiKey = mapElement.dataset.googleApiKey

    const showPickupResponse = (data) => {
      pickup = data.results[0].geometry.location;
      console.log(pickup);
    }

    const getPickupAddress = (pickup, drop) => {
      https://maps.googleapis.com/maps/api/directions/json?origin=angers&destination=paris&key=${apiKey}

      fetch(`https://maps.googleapis.com/maps/api/directions/json?origin=${pickup}&destination=${drop}&key=${apiKey}`)
      .then(response => response.json())
      .then(showPickupResponse);
    };

    const pickupInput = document.getElementById('course_pickups_attributes_0_address');
    pickupInput.addEventListener("input", (event) => {
      const pickupAddress = event.originalTarget.value;
      getPickupAddress(pickupAddress);
    });
  });
}

export { getRoutes }
