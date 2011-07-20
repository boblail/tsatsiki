class ProjectUsersController < ProjectResourceController
  uses_freight_train
  
  # load_and_authorize_resource, :class => "User"
  # check_authorization
  
  
  
  def create
    if User.where(:email => params[:user][:email]).count.zero?
      @invited_user = User.invite!(params[:user], current_user)
      
      params[:freight_train] = true
      params[:ft] = {:partial => "users/user"}
      respond_with(@invited_user)
    else
      show_error "That email address is already taken"
    end
  end
  
  
  
  def update
    @invited_user = User.find(params[:id])
    
    authorized_user = AuthorizedProject.find_or_create_by_user_id_and_project_id(@invited_user.id, @project.id)
    authorized_user.privileges.merge! params[:user][:privileges]
    
    if authorized_user.save
      params[:freight_train] = true
      params[:ft] = {:partial => "users/user"}
      respond_with(@invited_user)
    else
      show_errors_for(authorized_user)
    end
  end
  
  
  
end
