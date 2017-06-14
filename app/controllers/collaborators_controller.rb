class CollaboratorsController < ApplicationController
  
  before_action :set_wiki
  
  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])
    
    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaboration failed. Try again!"
      redirect_to new_wiki_collaborator
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    
    if @collaborator.destroy
      flash[:notice] = "A collaborator for this wiki has been removed."
      redirect_to @wiki
    else
      flash[:error] = "Collaboration failed. Try again!"
      redirect_to @wiki
    end
  end
  
  private
  
  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
