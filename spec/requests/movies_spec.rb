require 'rails_helper'

RSpec.describe "Movies", type: :request do
  describe "GET /index" do
    subject { get movies_path }

    it "returns http success" do
      subject
      expect(response).to have_http_status(:success)
    end

    it "renders the expected template" do
      subject
      expect(response).to render_template(:index)
    end
  end

  describe "post /search" do
    subject { post search_movies_path(format: :turbo_stream) }

    it "returns http success" do
      subject
      expect(response).to have_http_status(:success)
    end

    it "renders the expected template" do
      subject
      expect(response).to render_template(:search)
    end

    context "when requesting the wrong format" do
      subject { post search_movies_path }

      it "returns http Not Acceptable" do
        subject
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end
end
