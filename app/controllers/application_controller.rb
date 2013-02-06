class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers

  protect_from_forgery

  rescue_from ActionController::RoutingError,       :with => :render_404
  rescue_from ActionController::UnknownController,  :with => :render_404
  rescue_from AbstractController::ActionNotFound,      :with => :render_404
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def render_404
    redirect_to '/404.html'
  end

  def current_user
    Publisher.find session[:user_id] unless session[:user_id].nil?
  end

  def logout
    session[:user_id] = nil
    redirect_to :root
  end

  def login
    render 'login', :layout => true
  end

  def jsonp
    str = 'hello world';
    func = params[:callback]
    render :js => 
      "try{" + 
        "#{func}({ str : '#{str}' });" + 
      "}catch(e){" + 
        "console.error('request error');" + 
      "}"
  end

  def cors
    response.headers['Access-Control-Allow-Origin'] = '*';
    response.headers['Access-Control-Allow-Methods'] = 'GET';
    response.headers['Access-Control-Max-Age'] = '60';

    str = 'hello cors';
    render :json => "{ \"src\" : \"#{str}\" }"
  end

  def cross_post
    
  end

  def authorize

    if simple_captcha_valid?
      params[:publisher][:password] = Digest::MD5.hexdigest params[:publisher][:password]
      matched_publishers = Publisher.where params[:publisher]
      unless matched_publishers.empty? then
        session[:user_id] = matched_publishers.first.id
        redirect_to publisher_path(matched_publishers.first)
      else
        redirect_to login_path
      end
    else
      render 'login', :layout => true
    end
  end

end
