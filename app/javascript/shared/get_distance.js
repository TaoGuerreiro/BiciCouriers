const distance = () => {
  document.addEventListener("turbolinks:load", (event) => {

    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');

    const getDistance = (pickup, drop) => {
      https://maps.googleapis.com/maps/api/directions/json?origin=angers&destination=paris&key=${apiKey}

      fetch("/courses/distance")
      .then(response => response.json())
      .then((data) => {
        console.log(data)
    });


    };

    const pickupInput = document.getElementById('course_drops_attributes_0_address');
    pickupInput.addEventListener("input", (event) => {
      getDistance(puAddress, drAddress);
    });





  });
}

export { distance }
