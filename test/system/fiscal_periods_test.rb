require "application_system_test_case"

class FiscalPeriodsTest < ApplicationSystemTestCase
  setup do
    @fiscal_period = fiscal_periods(:one)
  end

  test "visiting the index" do
    visit fiscal_periods_url
    assert_selector "h1", text: "Fiscal periods"
  end

  test "should create fiscal period" do
    visit fiscal_periods_url
    click_on "New fiscal period"

    fill_in "End at", with: @fiscal_period.end_at
    fill_in "Start at", with: @fiscal_period.start_at
    click_on "Create Fiscal period"

    assert_text "Fiscal period was successfully created"
    click_on "Back"
  end

  test "should update Fiscal period" do
    visit fiscal_period_url(@fiscal_period)
    click_on "Edit this fiscal period", match: :first

    fill_in "End at", with: @fiscal_period.end_at
    fill_in "Start at", with: @fiscal_period.start_at
    click_on "Update Fiscal period"

    assert_text "Fiscal period was successfully updated"
    click_on "Back"
  end

  test "should destroy Fiscal period" do
    visit fiscal_period_url(@fiscal_period)
    click_on "Destroy this fiscal period", match: :first

    assert_text "Fiscal period was successfully destroyed"
  end
end
