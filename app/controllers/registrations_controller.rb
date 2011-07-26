class RegistrationsController < ApplicationController

  before_filter :find_page, :set_form

  def index
    render 'pages/join'
  end

  def create
    if @registration.valid? && @registration.save      
      flash[:success] = t('.thank_you_for_registration')
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
      
      redirect_to '/join-us'
    else
      flash[:error] = t('.problems_on_registration')
      render 'pages/join'
    end
  end

  protected

  def find_page
    @page = Page.find_by_title('Pridaj sa')
  end

  def set_form
    @registration = Registration.new(params[:registration])
  end

end
