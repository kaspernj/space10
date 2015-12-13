require 'rails_helper'

RSpec.describe 'Search feature', type: :request do
  describe 'searching' do
    let!(:post_relevant)    { create(:post, title: 'Superman', excerpt: 'Bla bla bla') }
    let!(:post_irrelvant)   { create(:post, title: 'Bla bla', excerpt: 'Nothing') }
    let!(:event_relevant)   { create(:event, title: 'Huge evnent', excerpt: 'Superman') }
    let!(:event_irelevant)  { create(:event, title: 'Nothing', excerpt: 'Bla') }

    it "returns relevant records" do
      post '/search', query: "Superman", format: :js
      
      expect(response_body['results'].map { |k,v| k['title'] }).to eq [post_relevant.title, event_relevant.title]
    end
  end
end