class Block < ActiveRecord::Base
  attr_accessible :original, :translation, :article
  belongs_to :article
end

