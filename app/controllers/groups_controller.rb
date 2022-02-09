class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.valid?
      @group.save
      @group.group_users.create!(user: current_user)

      redirect_to @group
    else
      render :new
    end
  end

  def show
    @group = current_user.groups.find(params[:id])
    @uninvited = User.where.not(id: @group.users.pluck(:id))
  rescue ActiveRecord::RecordNotFound
    render 'errors/404', status: 404
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
