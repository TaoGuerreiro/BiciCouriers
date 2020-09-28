import { fetchWithToken } from "../utils/fetch_with_token";


const getUrgence = (pus, pue, drs, dre, pud, drd, urDisplay, heDisplay) => {

  let data = { urgence: { puStart:pus, puEnd:pue, drStart:drs, drEnd:dre, stDate:pud, ndDate:drd }}
  return fetchWithToken("/course/ticket_urgence", {
    method: "POST",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    body: JSON.stringify(data)
  })
  .then(response => response.json())
  .then((data) => {
    urDisplay.innerHTML = data.tickets_urgence
    heDisplay.innerHTML = "Livraison avant " + dre
    return data.tickets_urgence
  });
};

export { getUrgence }
