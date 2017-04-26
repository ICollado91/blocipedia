class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
  
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
  
  def update?
    user.admin? || @user == @wiki.user
  end
  
  def destroy?
    user.admin? || @user == @wiki.user
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
