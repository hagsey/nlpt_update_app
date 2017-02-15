class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :welcome
  def welcome
  end
  
  def home
    @updates = Update.order("created_at").limit(10)
  end
end
