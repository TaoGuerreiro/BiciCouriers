import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'card']

  connect() {
    console.log("ADVANTAGE")
  }
  getRandomInt = (max) => {
    return Math.floor(Math.random() * max);
  }

  fly(event) {
      const xAxe = this.getRandomInt(2);
      const yAxe = this.getRandomInt(2);
      console.log(event.target.classList);
      event.target.classList.add('transform');
      if (xAxe == 1) {
        event.target.classList.add('translate-x-96');
      } else {
        event.target.classList.add('-translate-x-96');
      }
      if (yAxe == 1) {
        event.target.classList.add('translate-y-96');
      } else {
        event.target.classList.add('-translate-y-96');
      }
      event.target.classList.add('opacity-0');
      event.target.classList.remove('z-30');
      event.target.classList.add('z-0');
      setTimeout(() => { event.target.classList.add('hidden')}, 500);
  }

  reset() {
    this.cardTargets.forEach((card) => {
      card.classList.remove('hidden')
      setTimeout(() => {
        card.classList.remove('opacity-0')
        card.classList.remove('z-0');
        card.classList.add('z-30');
        card.classList.remove('-translate-x-96');
        card.classList.remove('translate-y-96');
        card.classList.remove('-translate-y-96');
        card.classList.remove('translate-x-96');
      }, 500);

    });
  }
}
