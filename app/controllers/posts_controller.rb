class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :set_post, only: [:preview]

  MAX_DESCRIPTION_LENGTH = 80;

  # GET /posts
  # GET /posts.json
  def index
    # Filter by ransacked parameters
    @search = Post.ransack(params[:q])

    # Subset with distinct and approved posts
    @posts = @search.result(distinct: true).where(approved: true)

    # Remove archived elements from index
    @posts = @posts.where(archived: false) unless params.key? :search_archive

    # Sort ascending by date
    # This should probably be done elsewhere so it doesn't have
    # to happen every time
    @posts = @posts.sort_by do |post|
      post.expire_date
    end
    @search.build_condition
  end

  # Goes to queue of unapproved posts
  # GET /approve_posts
  def approve_posts
    if current_user.is_admin?
      @posts = Post.where(approved: false).rewhere(archived: false)
    else
      redirect_to posts_url
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end



  # GET /posts/1/edit
  def edit
  end

  # Preview post
  def preview
  end

  # Approve an individual post
  # GET /posts/1/approve
  def approve
    post_id = params[:id]
    if current_user.is_admin?
      current_post = Post.find(post_id)
      current_post.update(approved: true)
      redirect_to '/approve_posts'
    else
      redirect_to posts_url
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    #preview is a paremeter passed when the user clicks the preview button on the new post page
    #in this case, the "newer.html.erb" page should be loaded, which is the same as the new post page, but will preview the last submitted post.
    #note that the captcha is bypassed here because nothing is being save to the database
    if (params[:preview])
        respond_to do |format|
          format.html { render :newer }
        end
    else
      respond_to do |format|
        if verify_recaptcha(model: @post) && @post.save
          format.html { redirect_to root_path, notice: 'Post was added to approval queue.' }
          notify_users @post
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if current_user.is_admin?
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to posts_path, notice: 'Only administrators can update posts.'
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if current_user.is_admin?
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to posts_path, notice: 'Only administrators can destroy posts.'
    end
  end

  # Toggles post's save boolean for current user
  # GET posts/:id/toggle_save
  def toggle_save
    selected_post = Post.find(params[:id])
    current_user.toggle_save(selected_post)
    #redirect_to posts_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :expire_date, :offer_type, :location, :tag_list => [])
    end

    # Notify users of new job posting
    def notify_users(new_post)
      User.all.each do |u|
        if u.wants_notifications?
          UserMailer.new_posting_email(u, new_post).deliver_now
        end
      end
    end
end
