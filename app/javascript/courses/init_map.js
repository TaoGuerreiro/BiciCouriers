const initMap = (pickup, drop) => {  
  const directionsDisplay = new google.maps.DirectionsRenderer();
  const directionsService = new google.maps.DirectionsService();
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
  
  const onChangeHandler = () => {
    displayRoute(pickup, drop, directionsDisplay, directionsService);
  };
  pickup.addEventListener("change", onChangeHandler)
  drop.addEventListener("change", onChangeHandler)
}
   
const displayRoute = (pickup, drop, display, service) => {
  if (pickup.value === "" || drop.value === "") {
    return 
  }
  // console.log(pickup.value)
  // console.log(drop.value)
  const request = {
    origin: pickup.value,
    destination: drop.value,
    travelMode: google.maps.DirectionsTravelMode.WALKING
  };
  service.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      // console.log(status)
      display.setDirections(response); 
    } else {
      console.log("Erreur, une des adresses doit être problèmatique => " + status);
    }
  });
}

export { initMap, displayRoute };
