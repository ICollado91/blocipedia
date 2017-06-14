class Wiki < ApplicationRecord
  
  has_many :collaborators
  has_many :users, through: :collaborators
  
  def set_wiki_to_public
      self.private = false
  end
  
  def public?
    !self.private
  end
  
  def find_author_of_wiki
    User.all.each do |user|
      if self.author == user.username
        return user
      end
    end
  end
  
end
