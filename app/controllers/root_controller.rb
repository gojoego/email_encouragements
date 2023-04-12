class RootController < ApplicationController
  def create
    EmailMailer.send_email.deliver_later
    redirect_to root_path, notice: "Mock email sent!"
  end
end
