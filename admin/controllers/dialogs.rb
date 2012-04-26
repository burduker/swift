Admin.controllers :dialogs do
  layout :ajax

  get :create_parent do
    @title = pat 'dialog.create_parent'
    render "dialogs/create_parent", :layout => :dialog
  end

  post :create_parent do
    content_type 'text/html'
    @object = params[:parent_model].constantize.create :title => params[:parent_title]
    return "error creating title: #{params[:parent_title]}"  unless @object

    content_type 'application/json'
    render "dialogs/create_parent.json"
  end

  get :pages do
    @tree = page_tree( nil, 0, '' )
    render "dialogs/pages"
  end

  get :images do
    @objects = Image.all
    render "dialogs/images"
  end

  get :assets do
    @objects = Asset.all
    render "dialogs/assets"
  end

  get :folders do
    @objects = Folder.all
    render "dialogs/folders"
  end

  get :cat_groups do
    @objects = CatGroup.all
    render "dialogs/cat_groups"
  end

  get :cat_cards do
    @objects = CatCard.all
    render "dialogs/cat_cards"
  end

  get :cat_nodes do
    @objects = CatNode.all
    render "dialogs/cat_nodes"
  end

  get :folder, :with => [:object_type, :folder_id] do
    folder = Folder.by_slug params[:folder_id]
    case params[:object_type]
    when 'images'
      @objects = folder ? folder.images : Image.all
      render "dialogs/folder_images"
    when 'assets'
      @objects = folder ? folder.assets : Asset.all
      render "dialogs/folder_assets"
    else
      'error'
    end
  end

  get :bonds, :with => [:parent_model, :parent_id] do
    @title = pat('dialog.title.bonds')
    render "dialogs/bonds", :layout => :dialog
  end

  get :bond, :with => [:parent_model, :parent_id] do
    @model = params[:parent_model].constantize  rescue nil
    return "no such model: #{params[:parent_model]}"  unless @model
    @object = @model.get params[:parent_id]
    return "no such object: #{model} ##{params[:parent_id]}"  unless @object
    @bonds = Bond.children_for @object
    render "dialogs/bonds_tab"
  end

  post :bonds_ajax, :with => [:parent_model, :parent_id] do
    content_type 'text/html'
    @model = params[:parent_model].constantize  rescue nil
    return "no such model: #{params[:parent_model]}"  unless @model
    @parent = @model.get params[:parent_id]
    return "no such parent: #{@model} ##{params[:parent_id]}"  unless @parent
    content_type 'application/json'

    Bond.separate @parent
    Array(params['bond']).each do |child_model, child_ids|
      @child_model = child_model.constantize  rescue nil
      return "no such model: #{@child_model}"  unless @child_model
      Array(child_ids).each do |child_id, value|
        next  unless value == 'on'
        @child = @child_model.get child_id
        return "no such child: #{@child_model} ##{child_id}"  unless @child
        return "failed to generate bond"  unless Bond.generate @parent, @child
      end      
    end
    
    @answer = { notice: 'all fine' }
    render "dialogs/bonds_ajax"
  end

end
