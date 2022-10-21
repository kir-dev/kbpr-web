import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["mobileNavPanel"]

    open() {
        const element = this.mobileNavPanelTarget
        element.classList.remove('hidden')
    }

    close() {
        const element = this.mobileNavPanelTarget
        element.classList.add('hidden')
    }
}
