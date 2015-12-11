require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'searching' do
    let!(:post_relevant_1) { create(:post, title: 'Superman', excerpt: 'Bla bla bla')}
    let!(:post_relevant_2) { create(:post, title: 'Bla bla', excerpt: 'Superman')}
    let!(:post_irrelvant_1) { create(:post, title: 'Bla bla', excerpt: 'Nothing')}
    let!(:post_irrelvant_2) { create(:post, title: 'Bla Uh', excerpt: 'Something')}

    it "returns relevant records" do
      post :search, query: "Superman", format: :json
      response_body.map{|p| p[:]}.should == [post_relevant_1, post_relevant_2]
    end
  end
end