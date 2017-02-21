class LinksController < ApplicationController
  before_action :find_link, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    if params[:tag]
      @link = Link.tagged_with(params[:tag])
    elsif params[:search]
      @link = Link.search(params[:search]).order("created_at DESC")
    else
      @category = Category.all
      @link = Link.all.order("created_at DESC").limit(10)
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.build(link_params)
    if @link.save
      redirect_to @link
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @link.update(link_params)
    if @link.save
      redirect_to @link
    else
      render "update"
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path
  end

  def upvote
    @link.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @link.downvote_by current_user
    redirect_to :back
  end

  def download
  @link = Link.find(params[:id])

  send_file @link.image.path,
              :filename => @link.image_file_name,
              :type => @link.image_content_type,
              :disposition => 'attachment'
end

  private

  def link_params
    params.require(:link).permit(:content, :title, :image, :tag_list, :category_id)
  end

  def find_link
    @link = Link.find(params[:id])
  end
end
