



const initMap = () => {
    document.addEventListener("turbolinks:load", () => {
      // addresses input
      const pickupInput = document.getElementById('course_pickups_attributes_0_address');
      const dropInput = document.getElementById('course_drops_attributes_0_address');
      if (pickupInput === null) {
        return
      }
  
      // favorites dropdown
      // const pickupFavInput = document.getElementById('favorite-pickup');
      // const dropFavInput = document.getElementById('favorite-drop');
  
  
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

        const request = {
          origin: pickupInput.value,
          destination: dropInput.value,
          travelMode: google.maps.DirectionsTravelMode.WALKING
        };
        directionsService.route(request, function(response, status) {
         if (status == google.maps.DirectionsStatus.OK) {
          distance = response.routes[0].legs[0].distance.value;
          directionsDisplay.setDirections(response);
           }
        });
      }
  
    });
  }
  
  
  export { initMap };
  