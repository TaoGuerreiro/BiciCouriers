import { fetchWithToken } from "../utils/fetch_with_token";

const getDistance = (pickup, drop, display) => {
  let input = { addresses: { puAddressName:pickup, drAddressName:drop }}
  return fetchWithToken("/course/distance", {
    method: "POST",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    body: JSON.stringify(input)
  })
  .then((response) => response.json())
  .then((dist) => {
    display.innerHTML = dist/1000 + ' km'
    return dist
  });
};


const getDistTicket = (dist, display) => {
  let data = { distance: { distanceM:dist }}
  return fetchWithToken("/course/ticket_distance", {
    method: "POST",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    body: JSON.stringify(data)
  })
  .then((response) => response.json())
  .then((data) => {
    display.innerHTML = data
  });
};

export { getDistance, getDistTicket }
