require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    sign_in(@user)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Comment", with: @order.comment
    check "Laminated" if @order.laminated
    fill_in "Link", with: @order.link
    fill_in "Paper size", with: @order.paper_size
    fill_in "Print quantity", with: @order.print_quantity
    check "Printed by me" if @order.printed_by_me
    check "Sticker" if @order.sticker
    fill_in "User", with: @order.user_id
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Comment", with: @order.comment
    check "Laminated" if @order.laminated
    fill_in "Link", with: @order.link
    fill_in "Paper size", with: @order.paper_size
    fill_in "Print quantity", with: @order.print_quantity
    check "Printed by me" if @order.printed_by_me
    check "Sticker" if @order.sticker
    fill_in "User", with: @order.user_id
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end
end
