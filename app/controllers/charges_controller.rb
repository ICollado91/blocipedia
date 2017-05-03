class ChargesController < ApplicationController

  class Amount
    def self.default
      15_00
    end
  end
  
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.username}",
      amount: Amount.default
    }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Membership - #{current_user.username}",
      currency: 'usd'
    )
    
    current_user.set_to_premium
    current_user.save!
    flash[:notice] = "You are a now a #{current_user.role_name.capitalize} member! Congratulations!"
    render users_show_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
  
end
