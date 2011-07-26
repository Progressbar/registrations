class Registration < ActiveRecord::Base

  acts_as_indexed :fields => [:username, :email, :personal_info, :state]

  validates :username, :presence => true, :length => { :in => 6..20 }
  validates :email, :presence => true, :uniqueness => true, :length => { :in => 6..42 }
  validates :personal_info, :presence => true, :length => { :in => 6..250 }
  validates :state, :presence => true, :format => { :with => /new|approved|rejected/ }

  filters_spam :message_field => :personal_info,
    :email_field => :email,
    :author_field => :username,
    :extra_spam_words => %w()
  
  
  scope :new, :conditions => {:state => 'new'}
  scope :approved, :conditions => {:state => 'approved'}
  scope :rejected, :conditions => {:state => 'rejected'}

  def approve!
    self.update_attribute(:state, 'approved')
  end

  def reject!
    self.update_attribute(:state, 'rejected')
  end

  def rejected?
    self.state == 'rejected'
  end

  def approved?
    self.state == 'approved'
  end

  def new?
    self.state == 'new'
  end

  def self.latest(number = 7, include_spam = false)
    include_spam ? limit(number) : ham.limit(number)
  end
end
