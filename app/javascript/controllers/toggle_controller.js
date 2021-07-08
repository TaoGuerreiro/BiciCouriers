import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'page_1', 'page_2', 'previous', 'next', 'submit']

  connect() {
    console.log("Connexion toggle") 
  }

  toggle(event) {
    event.preventDefault();
    this.page_1Target.classList.toggle("overflow-hidden")
    this.page_2Target.classList.toggle("overflow-hidden")
    this.previousTarget.classList.toggle("overflow-hidden")
    this.nextTarget.classList.toggle("overflow-hidden")
    this.submitTarget.classList.toggle("overflow-hidden")
    this.page_1Target.classList.toggle("w-0")
    this.page_2Target.classList.toggle("w-0")
    this.previousTarget.classList.toggle("w-0")
    this.nextTarget.classList.toggle("w-0")
    this.submitTarget.classList.toggle("w-0")
    this.page_1Target.classList.toggle("w-full")
    this.page_2Target.classList.toggle("w-full")
    
  }


}

