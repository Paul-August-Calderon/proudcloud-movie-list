import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "row" ]

    removeRow(event) {
        event.target.closest(".movie-row").remove()
    }
}