class GroupUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group

  def create
    @group_user = GroupUser.create!(
      user_id: params[:user_id],
      group_id: @group.id
    )
    redirect_to @group_user.group
  rescue ActiveRecord::RecordNotFound
    render 'errors/404', status: 404
  end

  private

  def find_group
    @group = current_user.groups.find(params[:group_id])
  end
end
