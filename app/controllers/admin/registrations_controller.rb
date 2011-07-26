module Admin
  class RegistrationsController < Admin::BaseController

    crudify :registration,
            :title_attribute => 'username', :xhr_paging => true

    helper_method :group_by_date

    before_filter :find_all_ham, :only => [:index, :approved, :rejected]
    before_filter :find_all_spam, :only => [:spam]
    before_filter :get_spam_count, :only => [:index, :spam, :approved, :rejected]

    def index
      @registrations = @registrations.unmoderated
      @registrations = @registrations.with_query(params[:search]) if searching?
      @registrations = @registrations.paginate({:page => params[:page]})
    end

    def approved
      unless params[:id].present?
        @registrations = @registrations.approved
        @registrations = @registrations.paginate({:page => params[:page]})
        render :action => 'index'
      else
        @registration = Registration.find(params[:id])
        @registration.approve!
        flash[:notice] = t('approved', :scope => 'admin.registration', :author => @registration.username)
        redirect_to :action => 'index'
      end
    end

    def rejected
      unless params[:id].present?
        @registrations = @registrations.rejected
        @registrations = @registrations.paginate({:page => params[:page]})
        render :action => 'index'
      else
        @registration = Registration.find(params[:id])
        @registration.reject!
        flash[:notice] = t('rejected', :scope => 'admin.registration', :author => @registration.username)
        redirect_to :action => 'index'
      end
    end

    def spam
      self.index
      render :action => 'index'
    end

    def toggle_spam
      find_registration
      @registration.toggle!(:spam)

      redirect_to :back
    end

  protected

    def find_all_ham
      @registrations = Registration.ham
    end

    def find_all_spam
      @registrations = Registration.spam
    end

    def get_spam_count
      @spam_count = Registration.count(:conditions => {:spam => true})
    end

  end
end