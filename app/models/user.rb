class User < ActiveRecord::Base
  # attr_accessible :email, :name, :role

  # has_many :authentications, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :pages, :dependent => :destroy

  validates_uniqueness_of :name

  # scope :authors, where(role: "author")

  extend FriendlyId
  friendly_id :name, use: [:slugged]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :omniauthable, :omniauth_providers => [:twitter, :evernote]

         # :token_authenticatable has been removed from Devise 3.2.2 or greater

  def self.authors
    where(role: "author")
  end

  def omniauth_identity(auth)
    self.name = auth["info"]["name"]
    self.email = auth["info"]["email"] if auth["info"]["email"]
    self.role = "author"

    authentications.build(
        :provider => auth['provider'],
        :uid => auth['uid'].to_s,
        :access_token => auth['credentials']['token']
        )
  end
end
