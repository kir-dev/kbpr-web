require 'rails_helper'

RSpec.describe "OrderManagements", type: :system do
  before do

    driven_by(:selenium)
  end

  it "enables me to create widgets" do

    user = create(:user)
    sign_in(user)
    visit 'orders/new'
    expect(page).to have_text("Widget was successfully created.")
  end
end
