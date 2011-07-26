class RegistrationMailer < ActionMailer::Base

  def confirmation(registration, request)
    subject     'Progressbar Hackarspace - Thank You for registration'
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration = registration
  end

  def approved_confirmation(registration, user, request)
    subject     'Progressbar Hackarspace - Your registration was approved! :-)'
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @user = user
    @registration = registration
  end

  def rejected_confirmation(registration, request)
    subject     'Progressbar Hackarspace - Your registration was rejected.'
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
