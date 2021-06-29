import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'page_1', 'page_2', 'previous', 'next']

  connect() {
    console.log("Connexion toggle") 
  }

  toggle(event) {
    this.page_1Target.classList.toggle("hidden")
    this.page_2Target.classList.toggle("hidden")
    this.previousTarget.classList.toggle("hidden")
    this.nextTarget.classList.toggle("hidden")
  }


}

