require 'rails_helper'

RSpec.describe "Movies", type: :system do
  let!(:highest_movie) { create(:movie, title: 'a', vote_average: 9) }
  let!(:middle_movie) { create(:movie, title: 'b', vote_average: 5) }
  let!(:lowest_movie) { create(:movie, title: 'c', vote_average: 0) }

  describe "Visiting /movies endpoint" do
    it "shows 3 movie rows with the highest rated movie highlighted" do
      visit '/movies/'

      expect(page).to have_selector('div.movie-row', count: 3)
      expect(page).to have_selector('div.movie-row.bg-green-300', count: 1)
      expect(page).to have_selector("div.bg-green-300#movie-id-#{highest_movie.id}", count: 1)
    end

    context 'when clicking on the X' do
      it "removes the movie row" do
        visit '/movies/'
        expect(page).to have_selector('div.movie-row', count: 3)

        find("div#movie-id-#{highest_movie.id}").click_button
        expect(page).to have_selector('div.movie-row', count: 2)
      end

      it 'dynamically highlights the highest rated movie' do
        visit '/movies/'
        find("div#movie-id-#{highest_movie.id}").click_button

        expect(page).to have_selector('div.movie-row', count: 2)
        expect(page).to have_selector('div.movie-row.bg-green-300', count: 1)
        expect(page).to have_selector("div.bg-green-300#movie-id-#{middle_movie.id}", count: 1)
      end

      context 'when the removed movie is rated lower' do
        it 'should retain the highlight' do
          visit '/movies/'
          find("div#movie-id-#{lowest_movie.id}").click_button

          expect(page).to have_selector('div.movie-row', count: 2)
          expect(page).to have_selector('div.movie-row.bg-green-300', count: 1)
          expect(page).to have_selector("div.bg-green-300#movie-id-#{highest_movie.id}", count: 1)
        end
      end
    end
  end

  describe "Searching on the /movies endpoint", js: true do
    let!(:new_highest_movie) { create(:movie, title: 'd', vote_average: 10) }
    let!(:new_movie) { create(:movie, title: 'e', vote_average: 5) }
    before do
      # stubbing movies to be displayed
      allow(Movie).to receive(:find).and_return(Movie.where(id: [ highest_movie.id, middle_movie.id, lowest_movie.id ]))
    end

    it 'adds clicked search results into the list' do
      visit '/movies/'
      find('form#search-bar').fill_in('query', with: new_movie.title)
      find("div#movie-#{new_movie.id}").click

      expect(page).to have_selector('div.movie-row', count: 4)
    end

    it "shouldn't show movies that are already listed" do
      visit '/movies/'
      find('form#search-bar').fill_in('query', with: highest_movie.title)
      expect(page).not_to have_selector("div#movie-#{highest_movie.id}")

      find('form#search-bar').fill_in('query', with: new_movie.title)
      expect(page).to have_selector("div#movie-#{new_movie.id}")
    end


    context 'when movies are added to the list' do
      it 'dynamically highlights the highest rated movie' do
        visit '/movies/'
        find('form#search-bar').fill_in('query', with: new_highest_movie.title)
        find("div#movie-#{new_highest_movie.id}").click

        expect(page).to have_selector('div.movie-row', count: 4)
        expect(page).to have_selector('div.movie-row.bg-green-300', count: 1)
        expect(page).to have_selector("div.bg-green-300#movie-id-#{new_highest_movie.id}", count: 1)
      end

      context 'when the added movie is lower rated' do
        it "shouldn't change the highlighted row" do
          visit '/movies/'
          find('form#search-bar').fill_in('query', with: new_movie.title)
          find("div#movie-#{new_movie.id}").click

          expect(page).to have_selector('div.movie-row', count: 4)
          expect(page).to have_selector('div.movie-row.bg-green-300', count: 1)
          expect(page).to have_selector("div.bg-green-300#movie-id-#{highest_movie.id}", count: 1)
        end
      end
    end
  end
end
