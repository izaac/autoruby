require 'rubygems'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'capybara/rspec'

GMAIL_USER = ENV['GMAIL_USER']
GMAIL_PASSWD = ENV['GMAIL_PASSWD']

describe 'the gmail email', :type => :feature do

  before(:all) do
    Capybara.current_driver = :selenium
    Capybara.app_host = 'https://gmail.com'
    Capybara.run_server = false
  end

  it 'should open the gmail login page' do
    visit '/'
    expect(page).to have_title 'Gmail'
    if page.has_link?('gmail-sign-in')
      page.click_link('gmail-sign-in')
    end

    File.write('tmp.html', page.body)

    within('#gaia_loginform') do
      fill_in 'Email', :with => GMAIL_USER
      click_on 'next'
    end

    if find_button('signIn')
      fill_in 'Passwd', :with => GMAIL_PASSWD
      click_on 'signIn'
    end
  end

  after(:each) do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

end
