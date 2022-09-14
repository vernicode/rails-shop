class UsersController < ApplicationController
  def create
    @resource = User.new(name: params[:name], surname: params[:surname])

    if @resource.save
      render json: @resource
    else
      render json: {
        errors: @resource.errors.full_messages
      }
    end
  end

  def index
    render json: User.all
  end

  def show
    @resource = find_resource
    
    render json: @resource
  end

  def update
    @resource = find_resource

    if @resource.update(resource_params)
      render json: @resource
    else
      render json: {
        errors: @resource.errors.full_messages
      }
    end
  end

  def destroy
    @resource = find_resource

    if @resource.destroy
      render json: {
        result: true
      }
    else
      render json: {
        errors: @resource.errors.full_messages
      }
    end
  end

  private

  def find_resource
    @find_resource ||= User.find(params[:id])
  end
  
  def resource_params
    params.require(:user).permit(:name, :surname)
  end
end
