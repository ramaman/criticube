ActiveAdmin.register User do

  filter :id
  filter :email
  filter :first_name
  filter :last_name
  filter :page_name
  filter :banned
  filter :created_at
  filter :updated_at

  controller do
    def update
      @user = User.find(params[:id])
      if !@user.is_super_admin?
        @user.banned = params[:user][:banned]
        if current_user.super_admin?
          @user.admin = params[:user][:admin]
          @user.cc_team = params[:user][:cc_team]
        end
        @user.save
      end
      redirect_to :action => 'show'
    end
    def destroy
      @user = User.find(params[:id])
      if current_user.super_admin?
        if !@user.is_super_admin?
          @user.destroy
        end
      end
      # prevent destroying admin here, unless by super admin
      redirect_to :action => 'index'
    end
  end

  member_action :lead, :method => :put do
    user = User.find(params[:id])
    user.lead = current_user
    user.save
    redirect_to :action => 'show'
  end
  
  action_item :only => :show do
    link_to('Lead contact', lead_admin_user_path(user), :method => :put)
  end

  index do
    id_column
    column :first_name
    column :last_name
    column :page_name    
    column :created_at
    column :updated_at
    default_actions
  end

  show do 
    panel "User Details" do
      attributes_table_for user do
        row("Name") { link_to(user.name, vanity_path(user)) }
        row("Banned") { user.banned }
        row("lead") { link_to(user.lead.name, vanity_path(user.lead)) if user.lead }
        row("Email") { user.email } if current_user.super_admin?
        row("Current sign in at") { user.current_sign_in_at }
        row("Last sign in at") { user.last_sign_in_at }
        row("Current sign in ip") { user.current_sign_in_ip }
        row("Last sign in ip") { user.last_sign_in_ip }
        row("Admin") { user.admin }
        row("Super admin") { user.super_admin }
      end
    end
    active_admin_comments
  end

  csv do
    column :first_name
    column :last_name
    column :page_name
    column :email
  end

  form do |f|  
    f.inputs "Details" do
      f.input :banned
      f.input :admin
      f.input :lead, :as => :select, :collection => User.where{cc_team == true}
    end
    f.buttons
  end
  
end