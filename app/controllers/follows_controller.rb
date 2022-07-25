class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ show edit update destroy ]
  before_action :lock_access,except: %i[ newFollow unFollow ]
  # GET /follows or /follows.json
  def index
    @follows = Follow.all
  end

  # GET /follows/1 or /follows/1.json
  def show
  end

  # GET /follows/new
  def new
    @follow = Follow.new
  end

  def newFollow
    @followee_id = params[:user_id]
    @follow = Follow.new(followee_id: @followee_id,follower_id: get_session)
    respond_to do |format|
      if @follow.save
        format.html { redirect_to feed_path, notice: "You just follow #{User.find(@followee_id).name}" }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  def unFollow
    @followee_id = params[:user_id]
    @follow = Follow.find_by(follower_id:get_session,followee_id:@followee_id)
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to feed_path, notice: "You just unfollow #{User.find(@followee_id).name}" }
      format.json { head :no_content }
    end
  end
  # GET /follows/1/edit
  def edit
  end

  # POST /follows or /follows.json
  def create
    @follow = Follow.new(follow_params)
    respond_to do |format|
      if @follow.save
        format.html { redirect_to @follow, notice: "Follow was successfully created." }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /follows/1 or /follows/1.json
  def update
    respond_to do |format|
      if @follow.update(follow_params)
        format.html { redirect_to @follow, notice: "Follow was successfully updated." }
        format.json { render :show, status: :ok, location: @follow }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1 or /follows/1.json
  def destroy
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to follows_url, notice: "Follow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def lock_access
    respond_to do |format|
      format.html { redirect_to main_path, notice: "You are not allow to access." }
      format.json { render :show, status: :created, location: @post }
    end
  end

  def get_session
    return session[:user_id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:follower_id, :followee_id)
    end
end
