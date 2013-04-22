class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :permalink_path, :published, :published_at, :slug, :title, :protect_slug
  
  scope :publisheds, where(:published => true)
  
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
  
  def should_generate_new_friendly_id?
    !self.protect_slug
    # Set protect_slug to true to keep the current url no matter if you change the Post title
    # this makes sure that the Hack a Marathon slug doesn't get changed by accident
    # If I want to make something match my old wordpress urls the way to do it is by
    # 1. Create the post with the words in the url as the title.
    #    - A url like this: /2011/05/rails-backbone-js-example-screencast/
    #      needs a Post title like this: Rails backbone js example screencast and the Protect check box checked    
  end
  
  
end