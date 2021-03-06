class VideosController < ApplicationController
  def index
    @html_id = 'page'
    @body_id = 'watch'

    @videos  = Video.published.page(params[:page]).per(20)
  end

  def show
    @video = Video.where(slug: params[:slug])
    return redirect_to [:videos] if @video.blank?

    @video    = @video.first
    @editable = @video

    @html_id  = 'page'
    @body_id  = 'video'
    @title    = @video.title
  end
end
