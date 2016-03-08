require 'rubygems'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'capybara/rspec'

GMAIL_USER = ENV['GMAIL_USER']
GMAIL_PASSWD = ENV['GMAIL_PASSWD']


class GmailLoginPage
  include Capybara::DSL
  include RSpec::Matchers

  def validate_on_page
    expect(page).to have_title 'Gmail'
    expect(page).to have_selector('.card')
    expect(page).to have_field('Email')
    expect(page).to have_button('next')
  end

  def validate_after_email
    expect(page).to have_field('Passwd')
  end

  def validate_bad_email
    expect(page).to have_selector('#errormsg_0_Email', visible: true)
  end

  def submit_email(email)
    fill_in 'Email', :with => email
  end

  def submit_password(passwd)
    fill_in 'Passwd', :with => passwd
  end

  def click_next
    click_button 'next'
  end

  def click_signin
    click_button 'signIn'
  end

end


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

  after(:each) do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

end
