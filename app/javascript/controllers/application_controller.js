import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

/* This is your ApplicationController.
 * All StimulusReflex controllers should inherit from this class.
 *
 * Example:
 *
 *   import ApplicationController from './application_controller'
 *
 *   export default class extends ApplicationController { ... }
 *
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends Controller {
  connect () {
    StimulusReflex.register(this)
    // console.log('reflex')
  }

  /* Application-wide lifecycle methods
   *
   * Use these methods to handle lifecycle concerns for the entire application.
   * Using the lifecycle is optional, so feel free to delete these stubs if you don't need them.
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "Example#demo"
   *
   *   error/noop - the error message (for reflexError), otherwise null
   *
   *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
   */
  beforeReflex(element, reflex, noop, reflexId) {
    // const form = document.querySelector('#new_course')
    // const formData = new FormData(form)
    // // console.log(form_data.values())
    // for(var pair of formData.entries()) {
    //   console.log(pair[0]+ ', '+ pair[1]);
    // }

    // const data = Array.from(formData, e => e.map(encodeURIComponent).join('='))

    // console.log(new Set(data))

    // console.log(Array.from(new Set(data)).join('&'))

    // // [form_data.entries()].forEach( pair => {
    // //     console.log(pair[0], " ", pair[1])
    // // });

    // // console.log(element.reflexData[reflexId])
    // const { params } = element.reflexData[reflexId]
    // console.log(params)
    // element.reflexData[reflexId].params = { ...params, foo: true, bar: false }
  }

  reflexSuccess (element, reflex, noop, reflexId) {
    // show success message
    console.log('success reflex')
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
    // console.log()
  }

  finalizeReflex (element, reflex, noop, reflexId) {
    // all operations have completed, animation etc is now safe
  }
}


// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = [ 'distance', 'volume', 'urgence', 'total']

//   connect() {
//     console.log("Connexion de l'application controller")
//   }

//   total() {
//     console.log(this.distanceTarget.innerText)
//     let sum = parseInt(this.distanceTarget.innerText) + parseInt(this.urgenceTarget.innerText) + parseInt(this.volumeTarget.innerText)
//     console.log(sum)
//     this.totalTarget.innerText = sum
//     }


// }
