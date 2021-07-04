import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'page_1', 'page_2', 'previous', 'next', 'submit']

  connect() {
    console.log("Connexion toggle") 
  }

  toggle(event) {
    event.preventDefault();
    this.page_1Target.classList.toggle("opacity-100")
    this.page_2Target.classList.toggle("opacity-100")
    this.previousTarget.classList.toggle("opacity-100")
    this.nextTarget.classList.toggle("opacity-100")
    this.submitTarget.classList.toggle("opacity-100")
    this.page_1Target.classList.toggle("opacity-0")
    this.page_2Target.classList.toggle("opacity-0")
    this.previousTarget.classList.toggle("opacity-0")
    this.nextTarget.classList.toggle("opacity-0")
    this.submitTarget.classList.toggle("opacity-0")
    this.page_1Target.classList.toggle("hidden")
    this.page_2Target.classList.toggle("hidden")
    this.previousTarget.classList.toggle("hidden")
    this.nextTarget.classList.toggle("hidden")
    this.submitTarget.classList.toggle("hidden")
  }


}

