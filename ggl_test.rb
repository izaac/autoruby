require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.

  def setup
    # Do nothing
    @selenium = Selenium::WebDriver.for(:firefox)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def test_search_ggl
    @selenium.get('https://www.google.com')
  end

  def teardown
    # Do nothing
    @selenium.quit
  end

end