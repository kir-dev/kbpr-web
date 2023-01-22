require "test_helper"

class FiscalPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fiscal_period = fiscal_periods(:one)
  end

  test "should get index" do
    get fiscal_periods_url
    assert_response :success
  end

  test "should get new" do
    get new_fiscal_period_url
    assert_response :success
  end

  test "should create fiscal_period" do
    assert_difference("FiscalPeriod.count") do
      post fiscal_periods_url, params: { fiscal_period: { end_at: @fiscal_period.end_at, start_at: @fiscal_period.start_at } }
    end

    assert_redirected_to fiscal_period_url(FiscalPeriod.last)
  end

  test "should show fiscal_period" do
    get fiscal_period_url(@fiscal_period)
    assert_response :success
  end

  test "should get edit" do
    get edit_fiscal_period_url(@fiscal_period)
    assert_response :success
  end

  test "should update fiscal_period" do
    patch fiscal_period_url(@fiscal_period), params: { fiscal_period: { end_at: @fiscal_period.end_at, start_at: @fiscal_period.start_at } }
    assert_redirected_to fiscal_period_url(@fiscal_period)
  end

  test "should destroy fiscal_period" do
    assert_difference("FiscalPeriod.count", -1) do
      delete fiscal_period_url(@fiscal_period)
    end

    assert_redirected_to fiscal_periods_url
  end
end
