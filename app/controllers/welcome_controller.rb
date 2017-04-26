class WelcomeController < ApplicationController
  
  before_action :authenticate_user! # Add to prevent unautheticated guests
  
  def index
  end

  def about
  end
end
