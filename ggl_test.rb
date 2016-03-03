require 'rubygems'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'capybara/rspec'

describe "the gmail email", :type => :feature do
  before(:all) do
    Capybara.current_driver = :selenium
    Capybara.app_host = 'https://gmail.com'
    Capybara.run_server = false
  end


  it "should open the gmail login page" do
    visit "/"
  end

  after(:each) do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

end
