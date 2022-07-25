class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[ login ]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in, except: %i[index main create new login login_page feed register profile]
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if logged_in
    else
      return
    end
  end

  def login_page
    session[:user_id] = nil
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def register
    @user = User.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.posts.each do |post|
      post.destroy
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def profile
    @user_follow = User.find_by(name:params[:name])
  end

  def login
    @user = User.new(user_params)
    respond_to do |format|
      if @user.validate_login != false
        session[:user_id] = @user.id
        format.html { redirect_to "/feed", notice: "User was successfully login." }
      else
        session[:user_id] = nil
        format.html { render :main, status: :unprocessable_entity, notice: "Please login."}
      end
    end
  end

  def main
    session[:user_id] = nil
    @user = User.new()
  end

  def logged_in
    if(get_session == @user.id)
      return true
    else
      respond_to do |format|
        format.html { redirect_to main_path, notice: "Please login." }
        format.json { render :show, status: :created, location: @post }
      end
    end
  end

  def get_session
    return session[:user_id]
  end

  def feed
    if get_session
      @user = User.find(get_session)
      @ids = @user.get_feed_post(@user.id)
    else
      respond_to do |format|
        format.html { redirect_to main_path, notice: "Please login." }
        format.json { render :show, status: :created, location: @post }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
