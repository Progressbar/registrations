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
        password = (0...20).map{ ('a'..'z').to_a[rand(26)] }.join
        
        u = User.create(:username => @registration.username, 
                        :email => @registration.email, 
                        :password => password, 
                        :password_confirmation => password)

        if u.valid?
          begin
            last_user = User.order('progressbar_uid ASC').limit(1).last
            u.add_role(:member)
            u.add_role(:refinery)
            u.plugins = ['fees']
            u.progressbar_uid = last_user.nil? ? u.id : last_user.progressbar_uid.to_i + 42
            u.send(:generate_reset_password_token!)
            u.save
            @registration.approve!
            RegistrationMailer.approved_confirmation(@registration, u, request).deliver
          rescue
            logger.warn "There was an error delivering an approved registration confirmation.\n#{$!}\n"
          end          
        else
          puts "#{@registration.email} - #{u.errors.to_s}"
        end
        
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
        begin        
          @registration = Registration.find(params[:id])
          @registration.reject!
          RegistrationMailer.rejected_confirmation(@registration, request).deliver
        rescue
          logger.warn "There was an error delivering an rejected registration confirmation.\n#{$!}\n"
        end   
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