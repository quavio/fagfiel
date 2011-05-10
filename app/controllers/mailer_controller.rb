class MailerController < ApplicationController
  skip_before_filter :authenticate_user!

  def contact
  end

  def new_order
  end

  def new_expectation
  end
  
  def update_expectation
  end

  def destroyed_expectation
  end

  def user_changed
  end

  def confirmation_instructions
    render "devise/mailer/confirmation_instructions"
  end
end
