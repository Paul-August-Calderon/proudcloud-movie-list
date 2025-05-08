import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["row", "query", "searchForm"]

    removeRow(event) {
        event.target.closest(".movie-row").remove()
    }

    searchMovies() {
        clearTimeout(this.debounceTimeout)
        this.debounceTimeout = setTimeout(() => {
            this.searchFormTarget.requestSubmit()
        }, 300)
    }
}