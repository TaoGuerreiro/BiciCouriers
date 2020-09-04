import { fetchWithToken } from "../utils/fetch_with_token";

const distance = () => {
  document.addEventListener("turbolinks:load", (event) => {


    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');

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
    });
    };

    const pickupInput = document.getElementById('course_drops_attributes_0_address');
    pickupInput.addEventListener("input", (event) => {
      getDistance(puAddress, drAddress);
    });


  });
}

export { distance }
