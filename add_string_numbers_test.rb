require "minitest/autorun"
require_relative "add_string_numbers"

describe "add string numbers" do
  it "returns 0 for empty string" do
    assert_equal 0, add_string_numbers("")
  end

  it "returns 0 for blank string" do
    assert_equal 0, add_string_numbers("    ")
  end
  it "returns 0 for blank string with newlines" do
    assert_equal 0, add_string_numbers("    \n\n")
  end

  it "works for a single number" do
    assert_equal 1, add_string_numbers("1")
  end

  it "works for a single number with spaces and newlines" do
    assert_equal 1, add_string_numbers(" 1   \n")
  end

  it "works for a multiple numbers separated by commas" do
    assert_equal 6, add_string_numbers("1,2,3")
  end
  it "works for a multiple numbers separated by commas with spaces and newlines" do
    assert_equal 6, add_string_numbers(" 1   \n, 2 , 3")
  end

  it "works for a multiple numbers separated by commas with spaces and newlines with extra comma at the end" do
    assert_equal 6, add_string_numbers(" 1   \n, 2 , 3, ")
  end
end
