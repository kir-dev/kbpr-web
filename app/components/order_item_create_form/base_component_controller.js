import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["addButton", "form"]

    connect() {
        console.log("Hello, Stimulus!", this.element);
    }

    openForm() {
        this.formTarget.classList.remove('hidden')
        this.addButtonTarget.classList.add('hidden')
    }

    closeForm() {
        this.formTarget.classList.add('hidden')
        this.addButtonTarget.classList.remove('hidden')
    }

}
