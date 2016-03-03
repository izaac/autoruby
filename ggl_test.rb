require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require 'capybara/dsl'
require 'cucumber'

class CapybaraTestCase < Test::Unit::TestCase
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

class MyTest < CapybaraTestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.

  def setup
    # Do nothing
    # @selenium = Selenium::WebDriver.for(:firefox)
    Capybara.current_driver = :selenium
    Capybara.app_host = 'https://gmail.com'
    Capybara.run_server = false
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def test_search_ggl
    visit('/')
  end

end
