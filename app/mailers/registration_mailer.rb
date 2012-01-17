class RegistrationMailer < ActionMailer::Base

  def confirmation(registration, request)
    subject     "#{RefinerySetting.find_or_set(:site_name, 'Progressbar Hackerspace')} - registration"
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration = registration
  end

  def approved_confirmation(registration, user, request)
    subject     "#{RefinerySetting.find_or_set(:site_name, 'Progressbar Hackerspace')} - #{t('.registration_approved')}"
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @user = user
    @new_password_url = edit_user_password_url(:host => request.host_with_port,
                                                :reset_password_token => @user.reset_password_token)
    @registration = registration
  end

  def rejected_confirmation(registration, request)
    subject     "#{RefinerySetting.find_or_set(:site_name, 'Progressbar Hackerspace')} - #{t('.registration_rejected')}"
    recipients  registration.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration = registration
  end

  def notification(registration, request)
    subject     "#{RefinerySetting.find_or_set(:site_name, 'Progressbar Hackerspace')} - #{t('.registration_notification')}"
    recipients  RefinerySetting.find_or_set(:registration_notification_recipients, RefinerySetting.find_or_set(:inquiry_notification_recipients, 'info@progressbar.sk'))
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @registration = registration
  end

end
