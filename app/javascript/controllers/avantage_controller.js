import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'card']

  connect() {
    console.log("ADVANTAGE")
  }

  fly(event) {
      console.log(event.target.classList)
    // this.cardTargets.forEach((card) => {
      let offsetLeft = 0;
      offsetLeft += 1000;
      event.target.style.position = "relative";
      event.target.style.left = (offsetLeft)+"px";
      // this.cardTarget.style.position = "relative";
      // this.cardTarget.style.left = (offsetLeft)+"px";
      // this.cardTarget.style.top = (offsetLeft)+"px";
    // })
  }
}
