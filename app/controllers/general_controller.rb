class GeneralController < ApplicationController
  def contact
    if request.post?
      Mailer.contact(current_user, params[:message]).deliver
      redirect_to contact_path, :notice => I18n.t("notices.contact.sent")
    end
  end
end
