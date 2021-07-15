import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex'


export default class extends Controller {
  static targets = ['pickup']

  connect() {
    StimulusReflex.register(this)
    console.log('reflex delivery')
  }

  beforeReflex() {
    console.log(this.pickupTarget.value)
  }

  createPickupSuccess(element, reflex, noop, reflexId) {
    element.innerText = '\nDanced like no one was watching! Was someone watching?'
    console.log("ok")
  }

  reflexError() {
    console.log('reflexError')
  }
  reflexSuccess() {
    console.log('reflexSuccess')
  }
  reflexHalted() {
    console.log('reflexHalted')
  }
  afterReflex() {
    console.log('afterReflex')
  }
  finalizeReflex() {
    console.log('finalizeReflex')
  }

}
