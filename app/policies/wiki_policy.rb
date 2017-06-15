class WikiPolicy < ApplicationPolicy
 
  attr_reader :user, :wiki
  
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
  
  def update?
    user.role == 0 || @user == @wiki.find_author_of_wiki || @wiki.collaborators.include?(@user)
  end
  
  def destroy?
    user.role == 0 || @user == @wiki.find_author_of_wiki || @wiki.collaborators.include?(@user)
  end
  
  class Scope < Scope
    attr_reader :user, :scope
 
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
 
    def resolve
      wikis = []
      if user.role_name == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role_name == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.find_author_of_wiki == user || wiki.collaborators.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
end
