class RegistrationsController < ApplicationController

  before_filter :default_pages, :find_page, :set_form
  
  def index
    render 'pages/join'
  end

  def create
    if @registration.valid? && @registration.save      
      flash[:success] = t('.registration_was_sent_successfully')
      if @registration.ham?
        begin
          RegistrationMailer.notification(@registration, request).deliver
        rescue
          logger.warn "There was an error delivering an registration notification.\n#{$!}\n"
        end

        begin
          RegistrationMailer.confirmation(@registration, request).deliver
        rescue
          logger.warn "There was an error delivering an registration confirmation:\n#{$!}\n"
        end
      end
      
      redirect_to url_for(@page)
    else
      flash[:error] = t('.problems_on_registration')
      render 'pages/join'
    end
  end

  protected

  def find_page
    @page = @join_us_page
  end

  def set_form
    @registration = Registration.new(params[:registration])
  end

end
