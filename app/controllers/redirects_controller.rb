class RedirectsController < ApplicationController
  def show
    @request_url = request.url
    @path = params[:path]

    if @site = Site.find_by_short_path(@path)
      redirect_to @site.get_destination
    end
  end

end
