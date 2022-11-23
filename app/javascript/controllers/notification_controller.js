import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["notificationBar"]


    close() {
        const element = this.notificationBarTarget
        element.remove()
        console.log("alert-close")
    }
}
