ActiveAdmin.register Cube do

  filter :language
  filter :name
  filter :page_name
  filter :featured
  filter :official
  filter :created_at
  filter :updated_at

  controller do
    def create
    end
    def update
      @cube = Cube.find(params[:id])
      @cube.featured = params[:cube][:featured]
      @cube.official = params[:cube][:official]
      @cube.language = params[:cube][:language]
      @cube.save
      redirect_to :action => 'show'
    end
    def destroy
      @cube = Cube.find(params[:id])
      if current_user.super_admin?
        @cube.destroy
      end
      # prevent destroying admin here, unless by super admin
      redirect_to :action => 'index'
    end
  end

  index do
    id_column
    column :language
    column :name
    column :page_name
    column :featured
    column :official
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|  
    f.inputs "Details" do
      f.input :featured
      f.input :official
      f.input :language
    end
    f.buttons
  end

  
end
