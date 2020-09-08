import { fetchWithToken } from "../utils/fetch_with_token";

const distance = () => {
  document.addEventListener("turbolinks:load", (event) => {


    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');
    const diDisplay = document.querySelector('.distance');
    const tiDisplay = document.querySelector('.tickets');

//______________________DISTANCE______________________
    let getDistance = (pickup, drop) => {

      const input = { addresses: { puAddressName: pickup, drAddressName: drop }}

      fetchWithToken("/course/distance", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(input)
      })
      .then(response => response.json())
      .then((dist) => {
        diDisplay.innerHTML = dist
        console.log(dist)
      });
    };


      //______________________TICKETS______________________
    let getTickets = (dist) => {
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
        return data
        console.log(data)
        tiDisplay.innerHTML = data
      });

    };

    const pickupInput = document.getElementById('course_drops_attributes_0_address');

    pickupInput.addEventListener("change", (event) => {

        console.log(puAddress.value)
        console.log(drAddress.value)

        const dist = getDistance(puAddress.value, drAddress.value)
        console.log(dist)


      // setTimeout(getTickets(dist), 5000);
    });

  });
}

export { distance }
