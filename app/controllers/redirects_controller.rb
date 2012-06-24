class RedirectsController < ApplicationController
  def show
    @params_path = params[:path].to_s
    @path = @params_path.match(/.......\z/).to_s
    @request = request
    @host_port = request.host_with_port

    if @site = Site.find_by_short_path(@path)
      redirect_to @site.get_destination
    end
  end

end
