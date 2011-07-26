class RegistrationMailer < ActionMailer::Base

  def confirmation(registration, request)
    subject     'Progressbar Hackerspace - Thank You for registration'
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration = registration
  end

  def approved_confirmation(registration, user, request)
    subject     'Progressbar Hackerspace - Your registration was approved! :-)'
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @user = user
    @new_password_url = edit_user_password_url(:host => request.host_with_port,
                                                :reset_password_token => @user.reset_password_token)
    @registration = registration
  end

  def rejected_confirmation(registration, request)
    subject     'Progressbar Hackerspace - Your registration was rejected.'
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration = registration
  end

  def notification(registration, request)
    subject     'New registration'
    recipients  RefinerySetting.find_or_set(:registration_notification_recipients, 'keraml@gmail.com')
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration = registration
  end

end
