Admin.controllers :images do

  get :index do
    @objects = Image.all
    render 'images/index'
  end

  get :new do
    @object = Image.new
    render 'images/new'
  end

  post :create do
    @object = Image.new(params[:image])
    if @object.save
      flash[:notice] = pat('image.created')
      redirect url(:images, :edit, :id => @object.id)
    else
      render 'images/new'
    end
  end

  get :edit, :with => :id do
    @object = Image.get(params[:id])
    render 'images/edit'
  end

  put :update, :with => :id do
    @object = Image.get(params[:id])
    if @object.update(params[:image])
      flash[:notice] = pat('image.updated')
      redirect url(:images, :edit, :id => @object.id)
    else
      render 'images/edit'
    end
  end

  delete :destroy, :with => :id do
    @object = Image.get(params[:id])
    if @object.destroy
      flash[:notice] = pat('image.destroyed')
    else
      flash[:error] = pat('image.not_destroyed')
    end
    redirect url(:images, :index)
  end
end