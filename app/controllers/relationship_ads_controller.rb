class RelationshipAdsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @ad = Ad.find(params[:relationship_ad][:followedad_id])
    @user = current_user
    current_user.followad!(@ad)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @ad = RelationshipAd.find(params[:id]).followedad
    @user = current_user
    current_user.unfollowad!(@ad)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end

