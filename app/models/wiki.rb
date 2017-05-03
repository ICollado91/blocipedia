class Wiki < ApplicationRecord
  belongs_to :user
  
  def set_wiki_to_public
      self.private = false
  end
end
