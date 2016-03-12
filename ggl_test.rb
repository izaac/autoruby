require 'rubygems'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'capybara/rspec'
require_relative 'pages/gmail_login_page'

GMAIL_USER = ENV['GMAIL_USER']
GMAIL_PASSWD = ENV['GMAIL_PASSWD']

describe 'the browser should open the gmail login page', :type => :feature do
  drive = GmailLoginPage.new

  before(:each) do
    Capybara.current_driver = :selenium
    Capybara.app_host = 'https://gmail.com'
    Capybara.run_server = false

  end

  it 'should fill in the email and password fields and login' do

    visit '/'
    drive.validate_on_page

    File.write('tmp.html', page.body)
    
    drive.submit_email GMAIL_USER
    drive.click_next

    drive.validate_after_email
    drive.submit_password GMAIL_PASSWD

  end

  it 'should display: doesnt recognize email' do

    visit '/'
    drive.validate_on_page

    drive.submit_email 'non.existing@email.com'
    drive.click_next

    drive.validate_bad_email

  end

  it 'should display: email and passwoed do not match' do

    visit '/'
    drive.validate_on_page


    drive.submit_email GMAIL_USER
    drive.click_next

    drive.validate_after_email
    drive.submit_password 'bad_passwd!'
    
    drive.click_signin
    drive.validate_bad_passwd

  end

  after(:each) do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

end
