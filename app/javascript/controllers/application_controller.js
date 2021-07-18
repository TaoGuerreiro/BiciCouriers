import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
  connect () {
    // StimulusReflex.register(this)
    // console.log('reflex')
  }

  beforeReflex(element, reflex, noop, reflexId) {

  }

  reflexSuccess (element, reflex, noop, reflexId) {
    // show success message
    // console.log('success reflex')
  }

  reflexError (element, reflex, error, reflexId) {
    // show error message
  }

  reflexHalted (element, reflex, error, reflexId) {
    // handle aborted Reflex action
  }

  afterReflex (element, reflex, noop, reflexId) {
    // // document.body.classList.remove('wait')
    // const { params } = element.reflexData[reflexId]
    // element.reflexData[reflexId].params = { ...params, foo: true, bar: false }
    // console.log(element.reflexData[reflexId])
  }

  finalizeReflex (element, reflex, noop, reflexId) {
    // all operations have completed, animation etc is now safe
  }
}
