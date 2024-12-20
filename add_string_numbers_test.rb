require "minitest/autorun"
require_relative "add_string_numbers"

describe "add string numbers" do
  it "returns 0 for empty string" do
    assert_equal 0, add("")
  end

  it "returns 0 for blank string" do
    assert_equal 0, add("    ")
  end
  it "returns 0 for blank string with newlines" do
    assert_equal 0, add("    \n\n")
  end

  it "works for a single number" do
    assert_equal 1, add("1")
  end

  it "works for a single number with spaces and newlines" do
    assert_equal 1, add(" 1   \n")
  end

  it "works for a multiple numbers separated by commas" do
    assert_equal 6, add("1,2,3")
  end
  it "works for a multiple numbers separated by commas with spaces and newlines" do
    assert_equal 6, add(" 1   \n, 2 , 3")
  end

  it "works for a multiple numbers separated by commas with spaces and newlines with extra comma at the end" do
    assert_equal 6, add(" 1   \n, 2 , 3, ")
  end

  it "returns exception if non-number string is passed" do
    exception = assert_raises(StringCalculatorError) do
      add("abc, bcd")
    end
    assert_match /non-numeric strings passed/, exception.message
  end

  it "returns exception if non-number is passed along with number" do
    exception = assert_raises(StringCalculatorError) do
      add("123, \n b,")
    end
    assert_match /non-numeric strings passed/, exception.message
  end

  it "returns exception if there is only a single comma" do
    assert_equal 0, add(",")
  end

  it "returns exception if there is special characters" do
    exception = assert_raises(StringCalculatorError) do
      add("$$")
    end
    assert_match /non-numeric strings passed/, exception.message
  end

  it "returns exception if there is negative numbers" do
    exception = assert_raises(StringCalculatorError) do
      add("1, 3, 4, -5")
    end
    assert_match /negative numbers not allowed <-5>/, exception.message
  end

  it "returns exception if there is multiple negative numbers" do
    exception = assert_raises(StringCalculatorError) do
      add("1, -3, 4, -5")
    end
    assert_match /negative numbers not allowed <-3,-5>/, exception.message
  end

  it "works for a multiple numbers separated by newlines and commas" do
    assert_equal 6, add("1\n2,3")
  end

  it "support different delimiters like semicolon" do
    assert_equal 3, add("//;\n1;2")
  end

  it "support different delimiters like $" do
    assert_equal 3, add("//$\n1$2")
  end

  it "raise error if no delimiter found" do
    exception = assert_raises(StringCalculatorError) do
      add("// \n1$2")
    end
    assert_match /no delimiter passed/, exception.message
  end

  it "raise error if anything other than string is passed" do
    exception = assert_raises(StringCalculatorError) do
      add([1, 2, 3])
    end
    assert_match /not a string/, exception.message
  end
end
