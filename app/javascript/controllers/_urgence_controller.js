import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ 'text', 'ticket', 'hourPickupStart', 'hourPickupEnd', 'hourDropStart', 'hourDropEnd', 'dateStart', 'dateEnd', 'urgence', 'urgenceDayText', 'urgenceHourText' ]

  ticket(event) {
      // // console.log(event.target.parentNode.dataset.start_day)
      
      // const pus = event.target.parentNode.dataset.start_hour
      // const pue = event.target.parentNode.dataset.end_hour
      // const drs = event.target.parentNode.dataset.start_hour
      // const dre = event.target.parentNode.dataset.end_hour
      // const pud = event.target.parentNode.dataset.start_day
      // const drd = event.target.parentNode.dataset.end_day

      // this.urgenceTargets.forEach((urgence) => urgence.classList.remove('active'))
      // event.target.parentNode.classList.add('active')

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
      //   this.fillInputs(pus, pue, drs, dre, pud, drd)
      //   this.ticketTarget.textContent = data.tickets_urgence
      //   this.textTarget.textContent = "Livraison avant " + dre
      //   return data.tickets_urgence
      // });
  }

  fillInputs = (pus, pue, drs, dre, pud, drd) => {
    this.hourPickupStartTarget.value = pus
    this.hourPickupEndTarget.value = pue
    this.hourDropStartTarget.value = drs
    this.hourDropEndTarget.value = dre
    this.dateStartTarget.value = pud
    this.dateEndTarget.value = drd
    
  }

  init = () => {
    // console.log("reset des horaires d'urgence")
    // // console.log(this.urgence0Target)

    // return fetchWithToken("/course/init_urgences", {
    //   method: "GET",
    //   headers: {
    //     "Accept": "application/json",
    //     "Content-Type": "application/json"
    //   }
    // })
    // .then(response => response.json())
    // .then((data) => {

    //     // console.log(this.urgenceDayTextTargets[2])
    //     // let i = 0
    //     // this.urgenceDayTextTargets.forEach((day) => {
    //     //   day.innerText = `data.urgence_${i}_day` 
    //     // ça interpole pas la variable, mais le text de la variable
    //     //   i ++
    //     // })
    //   this.hourPickupStartTarget.value = data.urgence_0_start_hour
    //   this.hourPickupEndTarget.value = data.urgence_0_end_hour
    //   this.hourDropStartTarget.value = data.urgence_0_start_hour
    //   this.hourDropEndTarget.value = data.urgence_0_end_hour
    //   this.dateStartTarget.value = data.urgence_0_start_date
    //   this.dateEndTarget.value = data.urgence_0_end_date

    //   this.urgenceHourTextTargets[0].innerText = data.urgence_0_end_hour
    //   this.urgenceDayTextTargets[0].innerText = data.urgence_0_day
    //   this.urgenceHourTextTargets[2].innerText = data.urgence_1_end_hour
    //   this.urgenceDayTextTargets[2].innerText = data.urgence_1_day
    //   this.urgenceHourTextTargets[1].innerText = data.urgence_2_end_hour
    //   this.urgenceDayTextTargets[1].innerText = data.urgence_2_day

    //   this.urgenceTargets[0].dataset.start_hour = data.urgence_0_start_hour
    //   this.urgenceTargets[2].dataset.start_hour = data.urgence_1_start_hour
    //   this.urgenceTargets[1].dataset.start_hour = data.urgence_2_start_hour
    //   this.urgenceTargets[0].dataset.end_hour = data.urgence_0_end_hour
    //   this.urgenceTargets[2].dataset.end_hour = data.urgence_1_end_hour
    //   this.urgenceTargets[1].dataset.end_hour = data.urgence_2_end_hour

    //   this.urgenceTargets[0].dataset.start_day = data.urgence_0_start_date
    //   this.urgenceTargets[2].dataset.start_day = data.urgence_1_start_date
    //   this.urgenceTargets[1].dataset.start_day = data.urgence_2_start_date
    //   this.urgenceTargets[0].dataset.end_day = data.urgence_0_end_date
    //   this.urgenceTargets[2].dataset.end_day = data.urgence_1_end_date
    //   this.urgenceTargets[1].dataset.end_day = data.urgence_2_end_date
    // });
  }
  choosing(event) {
    console.log(event.target.value)
    let data = { urgence: { id:event.target.value }}
 
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
        console.log(data)
        this.ticketTarget.textContent = data.tickets_urgence
        this.fillInputs(data.pus, data.pue, data.drs, data.dre, data.pud, data.drd)
        // this.textTarget.textContent = "Livraison avant " + dre
      });

  }

  connect() {
    console.log("Connexion de l'urgence controller")
    this.init()
    setInterval(this.init, 60000)
  }
}
