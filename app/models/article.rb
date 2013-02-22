class Article < ActiveRecord::Base
  attr_accessible :original, :translation, :uuid
  has_many :blocks
  attr_accessible :url
  validates_format_of :url, :with => URI::regexp(%w(http https))
end
