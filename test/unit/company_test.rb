require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # Replace this with your real tests.

  test "should save company" do
    company = Company.new
    assert company.save
  end
end
