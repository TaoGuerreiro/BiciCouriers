
const initShowMap = () => {
  document.addEventListener("turbolinks:load", (event) => {
    const pickupInput = document.getElementById('rec-address-pickup');
    const dropInput = document.getElementById('rec-address-drop');
    if (dropInput === null) {
      return
    }
    const directionsService = new google.maps.DirectionsService();
    const directionsDisplay = new google.maps.DirectionsRenderer();


    const myOptions = {
      zoom:13,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
    // styles: [
    //   {elementType: 'geometry', stylers: [{color: '#242f3e'}]},
    //   {elementType: 'labels.text.stroke', stylers: [{color: '#242f3e'}]},
    //   {elementType: 'labels.text.fill', stylers: [{color: '#746855'}]},
    //   {
    //     featureType: 'administrative.locality',
    //     elementType: 'labels.text.fill',
    //     stylers: [{color: '#d59563'}]
    //   },
    //   {
    //     featureType: 'poi',
    //     elementType: 'labels.text.fill',
    //     stylers: [{color: '#d59563'}]
    //   },
    //   {
    //     featureType: 'poi.park',
    //     elementType: 'geometry',
    //     stylers: [{color: '#263c3f'}]
    //   },
    //   {
    //     featureType: 'poi.park',
    //     elementType: 'labels.text.fill',
    //     stylers: [{color: '#6b9a76'}]
    //   },
    //   {
    //     featureType: 'road',
    //     elementType: 'geometry',
    //     stylers: [{color: '#38414e'}]
    //   },
    //   {
    //     featureType: 'road',
    //     elementType: 'geometry.stroke',
    //     stylers: [{color: '#212a37'}]
    //   },
    //   {
    //     featureType: 'road',
    //     elementType: 'labels.text.fill',
    //     stylers: [{color: '#9ca5b3'}]
    //   },
    //   {
    //     featureType: 'road.highway',
    //     elementType: 'geometry',
    //     stylers: [{color: '#746855'}]
    //   },
    //   {
    //     featureType: 'road.highway',
    //     elementType: 'geometry.stroke',
    //     stylers: [{color: '#1f2835'}]
    //   },
    //   {
    //     featureType: 'road.highway',
    //     elementType: 'labels.text.fill',
    //     stylers: [{color: '#f3d19c'}]
    //   },
    //   {
    //     featureType: 'transit',
    //     elementType: 'geometry',
    //     stylers: [{color: '#2f3948'}]
    //   },
    //   {
    //     featureType: 'transit.station',
    //     elementType: 'labels.text.fill',
    //     stylers: [{color: '#d59563'}]
    //   },
    //   {
    //     featureType: 'water',
    //     elementType: 'geometry',
    //     stylers: [{color: '#17263c'}]
    //   },
    //   {
    //     featureType: 'water',
    //     elementType: 'labels.text.fill',
    //     stylers: [{color: '#515c6d'}]
    //   },
    //   {
    //     featureType: 'water',
    //     elementType: 'labels.text.stroke',
    //     stylers: [{color: '#17263c'}]
    //   }
    // ]
  }

  const map = new google.maps.Map(document.getElementById("show-map-container"), myOptions);
  directionsDisplay.setMap(map);


  let distance = 0
  const request = {
    origin: pickupInput.innerText,
    destination: dropInput.innerText,
    travelMode: google.maps.DirectionsTravelMode.WALKING
  };

  directionsService.route(request, function(response, status) {
   if (status == google.maps.DirectionsStatus.OK) {
    distance = response.routes[0].legs[0].distance.value;
    directionsDisplay.setDirections(response);
  }
});
});
}

export { initShowMap };
