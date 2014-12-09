class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

def sign_in(user)
    cookies[:auth_token] = user.auth_token
    current_user = user

    Highrise::Base.site = user.site 
    Highrise::Base.user = user.token
    Highrise::Base.format = :xml
  end

  def new 
    if current_user
      redirect_to '/entries'
    else
      @user = User.new
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end
 
  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          sign_in @user
          format.html { redirect_to '/entries', notice: 'User was successfully created.' }
          format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :site, :token,:email, :password)
    end
end
