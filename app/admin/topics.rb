ActiveAdmin.register Topic do

  filter :name

  controller do
    def create
      @topic = Topic.new(params[:topic])
      @topic.creator = current_user
      @topic.save
      redirect_to admin_topic_path(@topic)      
    end
    def update
      @topic = Topic.find(params[:id])
      @topic.update_attributes(params[:topic])
      @topic.save
      redirect_to admin_topic_path(@topic)
    end
    def destroy
      @topic = Topic.find(params[:id])
      if current_user.is_super_admin?
        @topic.destroy
      end
      # prevent destroying here, unless by super admin
      redirect_to :action => 'index'
    end
  end

  index do
    id_column
    column :name        
    column :created_at    
    column :updated_at
    default_actions
  end  
  
  form do |f|  
    f.inputs "Details" do
      f.input :name
      f.input :description  
      f.input :avatar   
    end
    f.buttons
  end
  
end
