class RedirectsController < ApplicationController
  def show
    @request_url = request.url
    @path = params[:path]

    if @site = Site.find_by_short_path(@path)
      @destination = @site.get_destination
      redirect_to @destination
    end
  end

end
