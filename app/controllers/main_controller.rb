class MainController < ApplicationController
  def index
    redirect_to messages_path if user_signed_in?
  end
end
