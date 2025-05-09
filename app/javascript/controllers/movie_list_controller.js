import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["row", "rows", "query", "searchForm", "searchResult", "searchContainer"]

    connect() {
        this.clickOutside = this.clickOutside.bind(this);
        this.highlightHighestRated = this.highlightHighestRated.bind(this);
        document.addEventListener("click", this.clickOutside);

        this.rowsObserver = new MutationObserver(this.highlightHighestRated);
        this.rowsObserver.observe(this.rowsTarget, { childList: true });
    }

    disconnect() {
        this.rowsObserver.disconnect()
        document.removeEventListener("click", this.clickOutside);
    }

    removeRow(event) {
        event.target.closest(".movie-row").remove();
    }

    searchMovies() {
        clearTimeout(this.debounceTimeout);
        this.debounceTimeout = setTimeout(() => {
            this.appendMovieIds()
            this.searchFormTarget.requestSubmit()
        }, 300);
    }

    // this ensures already listed movies aren't in the search result
    // one alternative to this is to add/remove the hidden input during each add/remove
    appendMovieIds() {
        const form = document.getElementById('search-bar'); // TODO this can use the searchForm targets
        // clear existing hidden inputs
        [...document.getElementsByName("displayed_movie_ids[]")].forEach(e => e.remove()) // TODO this can use the rowTargets

        // parse and create elements
        const movieIds = this.rowTargets.map(row => row.getAttribute("data-movie-id"))
        const hiddenInputs = movieIds.map(createHiddenInput)

        hiddenInputs.forEach(input => {
            form.appendChild(input)
        })
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

    highlightHighestRated() {
        const movieIds = highestRated(this.rowTargets)
        // remove existing highlights then highlight new
        this.removeHighlight()
        // highlight rows again
        movieIds.forEach(id => document.getElementById(id).classList.add("bg-green-300"))
    }

    removeHighlight() {
        // this breaks if any other element using this bg color.
        // should be changed to something more unique or just iterate through all row and remove the color
        const highlightedRows = document.querySelectorAll(".bg-green-300")
        highlightedRows.forEach((row) => row.classList.remove("bg-green-300"));
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
            data-movie-list-target="row"
            data-movie-id = "${movie.id}"
             data-vote-average = "${movie.voteAverage}">
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

function createHiddenInput(id) {
    const hiddenInput = document.createElement('input');

    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'displayed_movie_ids[]');
    hiddenInput.setAttribute('value', id);

    return hiddenInput;
}

// returns array of ids of highest rated movies
function highestRated(movies) {
    let highestMovieIds = []
    let highestRating = 0.0

    const moviesArray = movies.map((movie) => {
        const id = movie.getAttribute("id");
        const vote_average = parseFloat(movie.getAttribute("data-vote-average"));
        return {
            id: id,
            vote_average: vote_average
        }
    })

    moviesArray.forEach((movie) => {
        if (movie.vote_average > highestRating) {
            highestRating = movie.vote_average
            highestMovieIds = [movie.id]
        }
        // To be consistent with movies that tie
        else if (movie.vote_average === highestRating) {
            highestMovieIds.push()
        }
    })

    return highestMovieIds;
}
