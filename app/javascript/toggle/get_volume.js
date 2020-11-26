import { fetchWithToken } from "../utils/fetch_with_token";


const getVolume = (size, voDisplay, voInput) => {

  let data = { volume: { size:size}}

  return fetchWithToken("/course/ticket_volume", {
  method: "POST",
  headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  },
  body: JSON.stringify(data)
  })
  .then(response => response.json())
  .then((data) => {
    voDisplay.innerHTML = data
    voInput.value = data
    console.log(data)
  });
};

export { getVolume }
