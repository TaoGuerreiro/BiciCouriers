import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex'


export default class extends Controller {
  static targets = ['pickup', 'drop']

  connect() {
    StimulusReflex.register(this)
    console.log('reflex delivery')
  }

  beforeReflex() {
    // console.log(this.pickupTarget.value)
  }

  createPickupSuccess(element, reflex, noop, reflexId) {
    // console.log(element)
    // element.innerText = '\nDanced like no one was watching! Was someone watching?'
    // console.log("ok")
    // this.calculDistance()
  }
  distanceSuccess() {
    console.log('OUI')
  }

  calculDistance = () => {
    // this.stimulate('Delivery#distance')
  }

  reflexError() {
    // console.log('reflexError')
  }
  reflexSuccess() {
    // console.log('reflexSuccess')
  }
  reflexHalted() {
    // console.log('reflexHalted')
  }
  afterReflex() {
    // console.log('afterReflex')
  }
  finalizeReflex() {
    // console.log('finalizeReflex')
  }

}
