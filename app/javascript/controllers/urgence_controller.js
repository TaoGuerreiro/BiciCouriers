import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ 'text', 'ticket', 'hourPickupStart', 'hourPickupEnd', 'hourDropStart', 'hourDropEnd', 'dateStart', 'dateEnd' ]

ticket() {
    console.log(this.hourPickupStartTarget)
    
    const pus = this.hourPickupStartTarget.nextElementSibling.innerHTML
    const pue = this.hourPickupEndTarget.nextElementSibling.innerHTML
    const drs = this.hourDropStartTarget.nextElementSibling.innerHTML
    const dre = this.hourDropEndTarget.nextElementSibling.innerHTML
    const pud = this.dateStartTarget.nextElementSibling.innerHTML
    const drd = this.dateEndTarget.nextElementSibling.innerHTML

    // let data = { urgence: { puStart:pus, puEnd:pue, drStart:drs, drEnd:dre, stDate:pud, ndDate:drd }}
    // return fetchWithToken("/course/ticket_urgence", {
    //   method: "POST",
    //   headers: {
    //     "Accept": "application/json",
    //     "Content-Type": "application/json"
    //   },
    //   body: JSON.stringify(data)
    // })
    // .then(response => response.json())
    // .then((data) => {
    //   this.ticketTarget.textContent = data.tickets_urgence
    //   this.textTarget.textContent = "Livraison avant " + dre
    //   return data.tickets_urgence
    // });
}

  connect() {
    console.log("Connexion de l'urgence controller")
    console.log(this.hourPickupStartTarget)

    const pus = this.hourPickupStartTarget
    const pue = this.hourPickupEndTarget
    const drs = this.hourDropStartTarget
    const dre = this.hourDropEndTarget
    const pud = this.dateStartTarget
    const drd = this.dateEndTarget

    return fetchWithToken("/course/init_urgences", {
      method: "GET",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      }
    })
    .then(response => response.json())
    .then((data) => {
      
    //   urgence_0_hour_input.innerText = data.urgence_0_end_hour
    //   urgence_0_day_input.innerText = data.urgence_0_day
    //   urgence_1_hour_input.innerText = data.urgence_1_end_hour
    //   urgence_1_day_input.innerText = data.urgence_1_day
    //   urgence_2_hour_input.innerText = data.urgence_2_end_hour
    //   urgence_2_day_input.innerText = data.urgence_2_day

    //   urgence_buttons[0].dataset.start_hour = data.urgence_0_start_hour
    //   urgence_buttons[2].dataset.start_hour = data.urgence_1_start_hour
    //   urgence_buttons[1].dataset.start_hour = data.urgence_2_start_hour
    //   urgence_buttons[0].dataset.end_hour = data.urgence_0_end_hour
    //   urgence_buttons[2].dataset.end_hour = data.urgence_1_end_hour
    //   urgence_buttons[1].dataset.end_hour = data.urgence_2_end_hour

    //   urgence_buttons[0].dataset.start_day = data.urgence_0_start_date
    //   urgence_buttons[2].dataset.start_day = data.urgence_1_start_date
    //   urgence_buttons[1].dataset.start_day = data.urgence_2_start_date
    //   urgence_buttons[0].dataset.end_day = data.urgence_0_end_date
    //   urgence_buttons[2].dataset.end_day = data.urgence_1_end_date
    //   urgence_buttons[1].dataset.end_day = data.urgence_2_end_date
    });

  }
}
