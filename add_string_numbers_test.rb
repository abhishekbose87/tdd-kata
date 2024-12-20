require "minitest/autorun"
require_relative "add_string_numbers"

describe "add string numbers" do
  it "returns 0 for empty string" do
    assert_equal 0, add_string_numbers("")
  end
end
