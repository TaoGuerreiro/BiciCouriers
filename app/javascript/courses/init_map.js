const initMap = () => {
    document.addEventListener("turbolinks:load", () => {
      
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
    });
  }
   
  const displayRoute = (pickup, drop) => {
    if (pickup.value === "" || drop.value === "") {
      return 
    }
    console.log(pickup.value)
    console.log(drop.value)
    const directionsDisplay = new google.maps.DirectionsRenderer();
    const directionsService = new google.maps.DirectionsService();
    const request = {
      origin: pickup.value,
      destination: drop.value,
      travelMode: google.maps.DirectionsTravelMode.WALKING
    };
    directionsService.route(request, function(response, status) {
     if (status == google.maps.DirectionsStatus.OK) {
       console.log(status)
       directionsDisplay.setDirections(response);
       console.log(response)
       }
    });
  }

  export { initMap, displayRoute };
  