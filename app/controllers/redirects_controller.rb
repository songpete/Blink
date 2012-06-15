class RedirectsController < ApplicationController
  def show
    @request_url = request.url
    @path = params[:path]

    if @site = Site.find_by_short_path(@path)
      @destination = @site.destination
      redirect_to @destination
    end

    # redirect_to ("http://www.google.com")
  end

end
