require_relative 'gmail_base_page'
class GmailLoginPage < GmailBasePage

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

  def validate_bad_passwd
    expect(page).to have_selector('#errormsg_0_Passwd', visible: true)
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
