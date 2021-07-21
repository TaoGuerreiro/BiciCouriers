import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex'
import places from 'places.js';


export default class extends Controller {
  static targets = ['pickup', 'drop', 'form']

  connect() {
    StimulusReflex.register(this)
    // console.log(this.pickupTarget.value)
  }

  afterNew() {
    this.displayDirection();
  }

  abort = () => {
    this.formTarget.classList.add("hidden");
  }

  finalizeDistance() {
    this.displayDirection();
  }

  displayDirection = () => {
  //   const pickupInput = document.getElementById('delivery_pickups_attributes_0_address');
  //   const dropInput = document.getElementById('delivery_drops_attributes_0_address');

  //   const directionsRenderer = new google.maps.DirectionsRenderer();
  //   const directionsService = new google.maps.DirectionsService();
  //   const map = new google.maps.Map(document.getElementById("map"), {
  //     zoom: 14,
  //     center: { lat: 47.217715, lng: -1.558234 },
  //   });
  //   directionsRenderer.setMap(map);
  //   calculateAndDisplayRoute(directionsService, directionsRenderer);

  // function calculateAndDisplayRoute(directionsService, directionsRenderer) {
  //   directionsService
  //     .route({
  //       origin: pickupInput,
  //       destination: dropInput,
  //       travelMode: google.maps.DirectionsTravelMode.WALKING,
  //     })
  //     .then((response) => {
  //       directionsRenderer.setDirections(response);
  //     })
  //     .catch((e) => window.alert("Directions request failed due to " + status));
  // }
  }

  initAddressAutoComplete = () => {
    const addressInput = document.querySelectorAll('.address-input')
    if (addressInput) {
      addressInput.forEach((input) => {
        places({
          container: input,
        });
      })
    }
  }

  beforeReflex() {
    // console.log("coucou")
  }

  distanceSuccess() {
    // console.log('OUI')
  }

  calculDistance = () => {
    // this.stimulate('Delivery#distance')
  }

  reflexError() {
    // console.log('reflexError')
  }
  createSuccess() {
    // this.abort();
  }

  reflexHalted() {
    // console.log('reflexHalted')
  }
  afterReflex() {
    // console.log('afterReflex')
    this.initAddressAutoComplete();
  }
  finalizeReflex() {
    // console.log('finalizeReflex')
  }

}
