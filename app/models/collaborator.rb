class Collaborator < ApplicationRecord
    
    belongs_to :user
    belongs_to :wiki
    
    def find_by_username
        collaber = User.find(self.user_id)
        collaber.username
    end
    
    def find_by_email
        collaber = User.find(self.user_id)
        collaber.email
    end
    
end
