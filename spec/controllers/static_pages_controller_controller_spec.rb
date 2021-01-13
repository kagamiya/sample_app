require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  it "gets root" do
    get :home
    expect(response).to be_success
    # visit '/static_pages/home'
    # expect(page).to have_css('title', text: :base_title)
  end
end
