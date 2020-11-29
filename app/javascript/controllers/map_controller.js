import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ 'map', 'pickup', 'drop' ]


    connect() {
        console.log('Connexion du map controller')
        const nantes = {lat: 47.2173, lng: -1.5534};
        const myOptions = {
            zoom:13,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            center: nantes
        }
        const map = new google.maps.Map(this.mapTarget, myOptions);

        
    }   


    displayRoutes = () => {
        const directionsDisplay = new google.maps.DirectionsRenderer();
        const directionsService = new google.maps.DirectionsService();
        if (this.pickupTarget.value === "" || this.dropTarget.value === ""  ) {
            return
        } else {
  
        const nantes = {lat: 47.2173, lng: -1.5534};
        const myOptions = {
            zoom:13,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            center: nantes
        }
        const map = new google.maps.Map(this.mapTarget, myOptions);

        directionsDisplay.setMap(map);
        // console.log(this.pickupTarget.nextElementSibling)
            const request = {
            origin: this.pickupTarget.value,
            destination: this.dropTarget.value,
            travelMode: google.maps.DirectionsTravelMode.WALKING
            };
            directionsService.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response); 
            } else {
                // console.log("Erreur, une des adresses doit être problèmatique => " + status);
            }
            }); 
        }
    }
}


