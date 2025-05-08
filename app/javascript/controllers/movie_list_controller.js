import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["row", "query", "searchForm", "searchResult", "searchContainer"]

    connect() {
        this.clickOutside = this.clickOutside.bind(this);
        document.addEventListener("click", this.clickOutside);
    }

    disconnect() {
        document.removeEventListener("click", this.clickOutside);
    }

    removeRow(event) {
        event.target.closest(".movie-row").remove();
    }

    searchMovies() {
        clearTimeout(this.debounceTimeout);
        this.debounceTimeout = setTimeout(() => {
            this.searchFormTarget.requestSubmit()
        }, 300);
    }

    addToList(event) {
        const rowHtml = formatMovieRowHTML(parseMovieDetail(event.target));
        const movieRowContainer = document.getElementById("movie-rows");

        movieRowContainer.insertAdjacentHTML("beforeend", rowHtml);
        event.target.remove();
    }

    hideResult () {
        this.searchResultTarget.classList.add("hidden");
    }

    showResult () {
        this.searchResultTarget.classList.remove("hidden");
    }

    clickOutside(event) {
        if (!this.searchContainerTarget.contains(event.target)) {
            this.hideResult();
        }
    }
}

// this expects the movie search result element you want to parse
function parseMovieDetail(movieSearchElement) {
    const id = movieSearchElement.getAttribute("data-movie-id");
    const title = movieSearchElement.getAttribute("data-title");
    const voteAverage = movieSearchElement.getAttribute("data-vote-average");
    const voteCount = movieSearchElement.getAttribute("data-vote-count");

    return {
        id: id,
        title: title,
        voteAverage: voteAverage,
        voteCount: voteCount
    };
}

// Alternatives to this would be keeping a html template to clone in the view or implement the row insert via turbo.
function formatMovieRowHTML(movie) {
    return `
    <div id="movie-id-${movie.id}" class="movie-row border h-10 rounded-md flex my-2"
            data-movie-list-target="row">
        <div class="w-1/2 flex items-center pl-[5%]">
             ${movie.title}
        </div>
        <div class="w-1/4 flex items-center justify-center">
            ${movie.voteAverage}
        </div>
        <div class="w-1/4 flex items-center justify-center">
            ${movie.voteCount}
        </div>
        <div class="w-1/20 text-4xl flex items-center justify-center">
            <button data-action="click->movie-list#removeRow">X</button>
        </div>
    </div>
    `;
}

