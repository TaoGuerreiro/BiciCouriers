import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex'


export default class extends Controller {
  static targets = ['total', 'urgence', 'volume', 'distance']

  connect() {
    StimulusReflex.register(this)
    // console.log('reflex delivery')
    // console.log(parseInt(this.distanceTarget.innerText, 10))
    // console.log(this.urgenceTarget || 0)
    // console.log(parseInt(this.volumeTarget.innerText, 10))
  }

  beforeReflex() {
    // console.log("coucou")
  }

  distanceSuccess() {
    // console.log('OUI')
  }

  calculDistance = () => {
    // this.stimulate('Delivery#distance')
  }

  reflexError() {
    // console.log('reflexError')
  }
  reflexSuccess() {
    // if (this.distanceTarget !== null) { const dist = parseInt(this.distanceTarget.innerText, 10) }
    // const urg = parseInt(this.urgenceTarget.innerText, 10) || 0
    // const vol = parseInt(this.volumeTarget.innerText, 10) || 0
    // this.totalTarget.innerText = (dist + urg + vol)
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
