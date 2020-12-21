import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'card']

  connect() {
    console.log("Connexion de l'avantage controller") 
  }

  fly(event) {
    console.log(event.target)
    console.log('test')
    // cardTarget.style.position = "relative";
    // card.style.left = (offsetLeft)+"px";
    // card.style.top = (offsetLeft)+"px";
  }
}





   
