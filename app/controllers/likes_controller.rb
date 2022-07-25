class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
  before_action :lock_access,except: %i[ newLike unLike ]
  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  def newLike
    @post_id = params[:post_id]
    @like = Like.new(post_id: @post_id,user_id: get_session)

    respond_to do |format|
      if @like.save
        format.html { redirect_to request.referrer, notice: "You like a post just a minute." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def unLike
    @post_id = params[:post_id]
    @like = Like.find_by(post_id:@post_id,user_id:get_session)
    @like.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "You unlike a post just a minute." }
      format.json { head :no_content }
    end
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_session
    return session[:user_id]
  end

  def lock_access
    respond_to do |format|
      format.html { redirect_to main_path, notice: "You are not allow to access." }
      format.json { render :show, status: :created, location: @post }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:post_id, :user_id)
    end
end
