class ContentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @contents = Content.all
    # render status: 200, json: contents
  end

  def new
    @content = Content.new
  end

  def create
    if @content.save(content_params)
      render 'index'
    #   render status: 201, json: {
    #     message: "Content saved",
    #     content: content
    #   }.to_json
    # else
    #   render status: 422, json: {
    #     errors: content.errors
    #   }.to_json
    end
  end

  def edit
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      redirect_to contents_path
    else
      redirect_to contents_path
    #   render status: 200, json: {
    #     message: "Content updated",
    #     content: content
    #   }.to_json
    # else
    #    render status: 422, json: {
    #     message: "The content could not be updated",
    #     errors: content.errors
    #   }.to_json
    end
  end

  def destroy
    @content = Content.find(params[:id])
    content.destroy

    # render status: 200, json: {
    #   message: "Content deleted"
    # }.to_json
  end

  private

  def content_params
    params.require(:content).permit(:paragraph)
  end

  def authenticate_admin!
    # check if current user is admin
    unless current_user.admin
      # if current_user is not admin redirect to some route
      redirect_to new_user_session_path
    end
    # if current_user is admin he will proceed to edit action
  end

end
