ActiveAdmin.register User do

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
        row("Name") { link_to(user.name, user_path(user)) }
        row("Banned") { user.banned }
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
    column :user_name
    column :email
  end

  form do |f|  
    f.inputs "Details" do
      f.input :banned
      f.input :subscribe_fact_updates
      f.input :subscribe_follow_updates
      f.input :admin     
    end
    f.buttons
  end

  
end
