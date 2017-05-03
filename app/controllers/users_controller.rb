class UsersController < ApplicationController
    def show
        #@user = User.find(params[:id])
        @wikis = current_user.wikis
    end
end
