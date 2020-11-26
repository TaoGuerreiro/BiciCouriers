import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ 'map', 'pickup', 'drop' ]


    connect() {
        console.log('Connexion du map controller')
        this.displayRoutes()
    }   


    displayRoutes = () => {
        const directionsDisplay = new google.maps.DirectionsRenderer();
        const directionsService = new google.maps.DirectionsService();
  
        const nantes = {lat: 47.2173, lng: -1.5534};
        const myOptions = {
            zoom:13,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            center: nantes
        }
        const map = new google.maps.Map(this.mapTarget, myOptions);

        directionsDisplay.setMap(map);
        // console.log(this.pickupTarget.nextElementSibling)
        if (this.pickupTarget.nextElementSibling === null || this.dropTarget.nextElementSibling === null  ) {
            return
        } else {
            const request = {
            origin: this.pickupTarget.nextElementSibling.innerHTML,
            destination: this.dropTarget.nextElementSibling.innerHTML,
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


