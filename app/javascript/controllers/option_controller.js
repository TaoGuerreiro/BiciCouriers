import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'


export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
    console.log('reflex option')
  }

  beforeReflex(element, reflex, noop, reflexId) {

  }

  reflexSuccess (element, reflex, noop, reflexId) {
    console.log('success reflex')
  }

  reflexError (element, reflex, error, reflexId) {
  }

  reflexHalted (element, reflex, error, reflexId) {
  }

  afterUrgence (element, reflex, noop, reflexId) {
    console.log("YES")
  }

  finalizeUrgence (element, reflex, noop, reflexId) {
    console.log(element)
  }
}
