import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'responsiveButton', 'userButton', 'responsiveMenu', 'userMenu', 'DOM' ]


    connect() {
        console.log('Connexion du controller NAVBAR')

    }   

    collapseResponsiveMenu () {
        this.responsiveMenuTarget.classList.toggle('hidden')
    }
    collapseUserMenu () {
        this.userMenuTarget.classList.toggle('hidden')
    }
    removeCollapse  (event) {
        if (event.target.parentNode.matches('[data-action]')) {
            return
        } else {
        this.userMenuTarget.classList.add('hidden')
        this.responsiveMenuTarget.classList.add('hidden')
        }
    }
}

