class Page < ActiveRecord::Base
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

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
