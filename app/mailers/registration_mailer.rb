class RegistrationMailer < ActionMailer::Base

  def confirmation(registration, request)
    subject     RegistrationSetting.confirmation_subject(Globalize.locale)
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to    RegistrationSetting.notification_recipients.split(',').first
    sent_on     Time.now
    @registration =  registration
  end

  def notification(registration, request)
    subject     RegistrationSetting.notification_subject
    recipients  RegistrationSetting.notification_recipients
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration =  registration
  end

end
