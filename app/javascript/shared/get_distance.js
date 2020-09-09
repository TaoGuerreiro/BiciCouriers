import { fetchWithToken } from "../utils/fetch_with_token";

const distance = () => {
  document.addEventListener("turbolinks:load", (event) => {


    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');
    const diDisplay = document.querySelector('.distance');
    const tiDisplay = document.querySelector('.tickets');

//______________________DISTANCE______________________
    let getDistance = (pickup, drop) => {

      let input = { addresses: { puAddressName: pickup, drAddressName: drop }}

      return fetchWithToken("/course/distance", {
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
        // console.log(dist)
        return dist
      });
    };

//______________________TICKETS______________________
    let getTickets = (dist) => {
      let data = { distance: { distanceM: dist }}
      return fetchWithToken("/course/tickets", {
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
        return data
      });

    };
//______________________EVENT______________________

    drAddress.addEventListener("change", (event) => {

      getDistance(puAddress.value, drAddress.value)
      .then((dist) =>
        getTickets(dist)
      )
    });
  });
}

export { distance }
