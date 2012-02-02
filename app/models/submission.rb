class Submission < ActiveRecord::Base

  validates :name, :presence => true
  validates :message, :presence => true
  validates :email, :format=> { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  acts_as_indexed :fields => [:first_name, :last_name, :email, :phone, :message, :your_interest, :how_did_you_find_us, :method_of_contact, :user_ip, :user_agent, :referrer]

  default_scope :order => 'created_at DESC'

  attr_accessible :name, :phone, :message, :email

  def self.latest(number = 7, include_spam = false)
    include_spam ? limit(number) : ham.limit(number)
  end
  
  def akismet_key
    RefinerySetting.find_or_set(:akismet_key,
      "Akismet Key"
    )  
  end
  
  def confirmation_body
    RefinerySetting.find_or_set(:submission_confirmation_body,
      "Thank you for filling out our contact form %name%,\n\nThis email is a receipt to confirm we have received your information and we'll be in touch shortly.\n\nThanks."
    )
  end

  def confirmation_subject(locale='en')
    RefinerySetting.find_or_set("submission_confirmation_subject_#{locale}".to_sym,
                                "Thank you for contacting us.")
  end

  def confirmation_subject=(value)
    value.first.keys.each do |locale|
      RefinerySetting.set("submission_confirmation_subject_#{locale}".to_sym, value.first[locale.to_sym])
    end
  end

  def confirmation_message(locale='en')
    RefinerySetting.find_or_set("submission_confirmation_messeage_#{locale}".to_sym,
                                RefinerySetting[:submission_confirmation_body])
  end

  def confirmation_message=(value)
    value.first.keys.each do |locale|
      RefinerySetting.set("submission_confirmation_messeage_#{locale}".to_sym, value.first[locale.to_sym])
    end
  end

  def notification_recipients
    RefinerySetting.find_or_set(:submission_notification_recipients,
                                ((Role[:refinery].users.first.email rescue nil) if defined?(Role)).to_s)
  end

  def notification_subject
    RefinerySetting.find_or_set(:submission_notification_subject,
                                "New contact form submission from your website")
  end

  def send_confirmation?
    RefinerySetting.find_or_set(:submission_send_confirmation, true)
  end

end
