class SitesController < ApplicationController
  before_filter :find_site, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:destroy, :edit]

  def index
    relation = Site
    relation = relation.where(user_id: params[:user_id]) if params[:user_id]

    @sites = relation.page(params[:page]).per(20)
    @page_count = params[:page].to_i
    @page_count = (@page_count - 1) * 20 unless (@page_count == 0)
  end

  def show
    @short_path = "#{root_url}#{@site.short_path}"
  end

  def new
    @site = Site.new
  end

  def edit
  end

  def create
    @site = Site.new(params[:site])
    render action: "edit" and return unless @site.check_destination_format

    if user_signed_in?
      @exists = current_user.sites.find_by_destination(@site.destination)
      current_user.sites << @site unless @exists
    else
      @exists = Site.anonymous_users.find_by_destination(@site.destination)
    end

    @site = @exists if @exists

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Short link successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site.destroy
    flash[:success] = "Short link was successfully deleted."

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def userlinks
    # @sites = current_user.sites
    @sites = current_user.sites.page(params[:page]).per(20)
    @page_count = params[:page].to_i
    @page_count = (@page_count - 1) * 20 unless (@page_count == 0)
  end

  private #-----------------------------------------------------------------

  def find_site
    @site = Site.find(params[:id])
  rescue
    render file: "public/404.html"
  end
end
