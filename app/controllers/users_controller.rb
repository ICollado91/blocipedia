class UsersController < ApplicationController
    def show
        #@user = User.find(params[:id])
        @wikis = current_user.wikis
    end
    
    def update
        current_user.set_to_standard
        @wikis = current_user.wikis
        @wikis.each do |wiki|
            wiki.private = false unless !wiki.private
            wiki.save!
        end
        flash[:notice] = "Your private wikis are now public and your account status is now #{current_user.role_name.capitalize}! No Refunds apparently!"
        render users_show_path
    end
end
