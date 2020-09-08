import { fetchWithToken } from "../utils/fetch_with_token";

const distance = () => {
  document.addEventListener("turbolinks:load", (event) => {


    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');
    const diDisplay = document.querySelector('.distance');
    const tiDisplay = document.querySelector('.tickets');

//______________________DISTANCE______________________
    const getDistance = (pickup, drop) => {
      const data = { addresses: { puAddressName: puAddress.value, drAddressName: drAddress.value }}

      fetchWithToken("/course/distance", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
      })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        diDisplay.innerHTML = data
      });
    };
      //______________________TICKETS______________________
    const getTickets = (dist) => {
      const data = { distance: { distanceM: dist }}
      fetchWithToken("/course/tickets", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
      })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        tiDisplay.innerHTML = data
      });
    };

    const pickupInput = document.getElementById('course_drops_attributes_0_address');
    let dist = 0
    pickupInput.addEventListener("change", (event) => {
      dist = getDistance(puAddress, drAddress);
    });

    pickupInput.addEventListener("change", (event) => {
      getTickets(dist);
    });
  });
}

export { distance }
