require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  before do
    # @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  it "gets root" do
    get :home
    expect(response.status).to eq(200)
    # expect(title).to match("#{@base_title}")
  end
end
