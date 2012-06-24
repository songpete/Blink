class RedirectsController < ApplicationController
  def show
    puts params.inspect
    debugger
    @path = params["path"].to_s
    @request = request
    @host_port = request.host_with_port

    if @site = Site.find_by_short_path(@path)
      redirect_to @site.get_destination
    end
  end

end
