import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'distance', 'volume', 'urgence', 'total']

  connect() {
    console.log("Connexion de l'application controller") 
  }

  total() {
    console.log(this.distanceTarget.innerText)
    let sum = parseInt(this.distanceTarget.innerText) + parseInt(this.urgenceTarget.innerText) + parseInt(this.volumeTarget.innerText)
    console.log(sum)
    this.totalTarget.innerText = sum
    }


}





   
