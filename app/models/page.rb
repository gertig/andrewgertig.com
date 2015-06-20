class Page < ActiveRecord::Base
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  before_save :published_post

  def published_post
    if self.published == true && self.published_at.nil?
     self.published_at = Time.now
    end
  end

  def published_on
    !published_at.nil? ? published_at.strftime("%B %e, %Y") : "Private"
  end

  def self.publisheds
    where(:published => true)
  end

  def description
    meta_description.nil? ? "#{strip_tags(strip_links(markdown(content.slice(0, 154).strip).to_html)).squish}..." : meta_description
  end

  def markdown(text)
    RedcarpetCompat.new(text, :fenced_code, :gh_blockcode)
  end

end
