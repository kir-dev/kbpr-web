require 'rails_helper'

RSpec.describe "OrderManagements", type: :system do
  include SystemHelper
  let!(:user) { create(:user) }
  let!(:item) { create(:item) }
  let!(:item_quantity) { 3 }
  before(:each) do
    sign_in(user)
  end

  it "enables me to create widgets" do
    visit 'orders/new'
    expect(page).to have_text("Rendelés leadás")
    # expect(find_field(id: 'order_total_price').value).to be(0)

    click_on 'Termék hozzáadása'
    fill_in('Plakát URL', with: 'www.example.com')
    fill_in('Mennyiség', with: item_quantity)
    select(item.name_with_price, from: 'Termék')
    click_on 'Hozzáad'
    # save_and_open_page
    price = price_from(find('#order_total_price').text)
    expect(price).to be(item.price*item_quantity)
  end
end
