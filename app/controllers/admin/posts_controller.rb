class Admin::PostsController < Admin::BaseController
  make_resourceful do
    actions :all

    response_for(:create) do
      redirect_to(:action => 'edit', :id => @post)
    end

    after(:create) do
      flash[:notice] = "Post created"
    end

    after(:update) do
      flash[:notice] = "Post updated"
    end

    response_for(:update) do
      redirect_to(:action => 'edit', :id => @post)
    end
  end

  protected

  def current_objects
    @current_object ||= current_model.paginate(
      :order => "created_at DESC", 
      :page => params[:page] 
    )
  end
end
