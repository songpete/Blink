class SitesController < ApplicationController
  before_filter :find_site, :only => [:show, :edit, :update, :destroy]

  def index
    @sites = Site.all
  end

  def show
    @short_path = request.host_with_port + '/' + @site.short_path
  end

  def new
    @site = Site.new
  end

  def edit
  end

  def create
    @site = Site.new(params[:site])
    @site.set_short_path
    current_user.sites << @site if user_signed_in?

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Short link successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
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

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  def userlinks
    @sites = current_user.sites
  end

  private

  def find_site
    @site = Site.find(params[:id])
  rescue
    render file: "public/404.html"
  end
end
