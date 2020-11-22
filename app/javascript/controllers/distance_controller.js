import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ 'distance', 'distanceTicket', 'pickup', 'drop']

  calcul() {
      const pu = this.pickupTarget.nextElementSibling.innerHTML
      const dr = this.dropTarget.nextElementSibling.innerHTML
        let input = { addresses: { puAddressName:pu, drAddressName:dr }}
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
            // console.log(dist)
            this.distanceTarget.textContent = dist/1000 + ' km'
            this.ticket(dist)
        });
  }

  ticket = (dist) =>  {
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
    this.distanceTicketTarget.textContent = data
  });
  }

  connect() {
    console.log('Connexion du distance controller')
  }
}
