class Submission < ActiveRecord::Base

  validates :first_name, :presence => true
  validates :message, :presence => true
  validates :email, :format=> { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  acts_as_indexed :fields => [:first_name, :last_name, :email, :phone, :message, :your_interest, :how_did_you_find_us, :method_of_contact, :user_ip, :user_agent, :referrer]

  default_scope :order => 'created_at DESC'

  attr_accessible :first_name, :last_name, :email, :phone, :message, :your_interest, :how_did_you_find_us, :method_of_contact
  
  before_create :check_for_spam
  
  def name
    [self.first_name, self.last_name].join(' ')
  end
  
  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end

  def check_for_spam
    if !akismet_key == "Akismet Key" || !full_site_url == "http://example.com"
      self.spam = !Akismetor.spam?(akismet_attributes)
    end
    true # return true so it doesn't stop save
  end

  def akismet_attributes
    {
      :key                  => akismet_key,
      :blog                 => full_site_url,
      :user_ip              => user_ip,
      :user_agent           => user_agent,
      :comment_author       => name,
      :comment_author_email => email,
      :comment_author_url   => email.split('@')[1],
      :comment_content      => message
    }
  end

  def mark_as_spam!
    update_attribute(:spam, false)
    Akismetor.submit_spam(akismet_attributes)
  end

  def mark_as_ham!
    update_attribute(:spam, true)
    Akismetor.submit_ham(akismet_attributes)
  end

  def self.latest(number = 7, include_spam = false)
    include_spam ? limit(number) : ham.limit(number)
  end
  
  def akismet_key
    RefinerySetting.find_or_set(:akismet_key, "Akismet Key")  
  end
  
  def full_site_url
    RefinerySetting.find_or_set(:full_site_url, "http://example.com") 
  end
  
  def self.confirmation_body
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

  def self.confirmation_message(locale='en')
    RefinerySetting.find_or_set("submission_confirmation_message_#{locale}".to_sym,
                                RefinerySetting[:submission_confirmation_body])
  end

  def self.confirmation_message=(value)
    value.first.keys.each do |locale|
      RefinerySetting.set("submission_confirmation_message_#{locale}".to_sym, value.first[locale.to_sym])
    end
  end

  def notification_recipients
    RefinerySetting.find_or_set(:submission_notification_recipients, "james@jamesrissler.com")
  end

  def notification_subject
    RefinerySetting.find_or_set(:submission_notification_subject,
                                "New contact form submission from your website")
  end

  def self.send_confirmation?
    RefinerySetting.find_or_set(:submission_send_confirmation, true)
  end

end
