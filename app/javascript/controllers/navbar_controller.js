import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["mobileNavPanel"]

    open() {
        const element = this.mobileNavPanelTarget
        //freez scrolling
        document.getElementsByTagName('body')[0].style.overflow = 'hidden';
        element.classList.remove('hidden')
    }

    close() {
        const element = this.mobileNavPanelTarget
        //unfreez scrolling
        document.getElementsByTagName('body')[0].style.overflow = 'visible'
        element.classList.add('hidden')

    }
}
