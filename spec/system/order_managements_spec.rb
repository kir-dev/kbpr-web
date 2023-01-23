require 'rails_helper'

RSpec.describe "OrderManagements", type: :system do
  let!(:user) { create(:user) }
  let!(:item) { create(:item) }
  let!(:item_quantity) { 3 }
  before(:each) do
    sign_in(user)
  end

  it "adds new order item" do
    visit 'orders/new'
    expect(page).to have_text("Rendelés leadás")
    expect(find('#order_total_price')).to have_content('0 JMF')

    click_on 'Termék hozzáadása'
    fill_in('Plakát URL', with: 'www.example.com')
    fill_in('Mennyiség', with: item_quantity)
    select(item.name_with_price, from: 'Termék')
    click_on 'Hozzáad'
    expect(find('#order_total_price')).to have_content('300.0 JMF')
  end
end
