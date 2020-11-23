import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ 'text', 'ticket', 'size' ]


  ticket(event)   {

    this.sizeTargets.forEach((size) => size.classList.remove('active'))
    event.target.parentNode.classList.add('active')

    //   console.log(event.target.parentNode.dataset.tickets)
      let number = parseInt(event.target.parentNode.dataset.tickets, 10)
    // const getVolume = (size, voDisplay, voInput) => {

        let data = { volume: { size:number}}
      
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
            this.ticketTarget.textContent = data
            // this.ticketTarget.textContent = data
        //   voInput.value = data
        //   console.log(data)
        });       
  }

  connect() {
    console.log('Connexion du volume controller')
  }
}
