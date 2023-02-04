import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["select", "dateForm", "startDate", "endDate"]
    connect(){
        console.log()
        this.change()
    }
    change() {
        console.log('hi')
        const select = this.selectTarget
        const dateForm = this.dateFormTarget
        // no fiscal period is selected
        if(select.value === '-1')
        {
            dateForm.classList.remove('hidden')
        }
        else
        {
            this.startDateTarget.value = null
            this.endDateTarget.value = null
            dateForm.classList.add('hidden')
        }

    }

}
