class Post < ActiveRecord::Base

  has_many :comments
  belongs_to :user

  has_many :post_votes
  has_many :users, :through => :post_votes
  
  validates :title, :user, :presence => :true
  validate :url_or_text

  def posted_on
    created_at.strftime("%A %B %d, %Y")
  end

  def url_or_text
    errors.add(:url, 'Must have url or text') if url.empty? && text.empty?
  end

  def full_url
    if self.url.match(/^https?:\/\//i)
      self.url
    else
      'http://' + self.url
    end
  end

  def url_domain
    url.gsub(/^https?:\/\//i, '').gsub(/\/.*/i, '')
  end

  def age
    Time.now.hour - created_at.hour
  end
end
