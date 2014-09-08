class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :shared_stuff
  def shared_stuff
    @year = '2013-2014'
    @year = '2013-2014'
  end
end
