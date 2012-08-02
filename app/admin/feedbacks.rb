ActiveAdmin.register Feedback do
  
  filter :responded
  filter :tipe
  filter :created_at
  filter :updated_at

  controller do
    def update
      @feedback = Feedback.find(params[:id])
      @feedback.responded = params[:feedback][:responded]
      @feedback.save!
      redirect_to admin_feedback_path(@feedback)
    end    

    def destroy
      @feedback = Feedback.find(params[:id])
      redirect_to :action => 'index'      
    end
  end

  index do
    id_column
    column :responded    
    column :creator
    column :tipe
    column :content
    column :created_at    
    column :updated_at
    default_actions
  end  

end