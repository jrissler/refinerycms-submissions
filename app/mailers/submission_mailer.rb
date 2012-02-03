class SubmissionMailer < ActionMailer::Base

  def confirmation(submission, request)
    subject submission.confirmation_subject(Globalize.locale)
    recipients submission.email
    from "\"#{Refinery[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to submission.notification_recipients.split(',').first
    sent_on Time.now
    @submission = submission
  end

  def notification(submission, request)
    subject submission.notification_subject
    recipients submission.notification_recipients
    from "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to submission.email
    sent_on Time.now
    @submission = submission
  end

end