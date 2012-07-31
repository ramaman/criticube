class SearchController < ApplicationController

  def main
    @q = params[:q]
    if @q && @q.length > 0
      search = Seek.main(params[:q], :paginate => {:page => params[:page], :per_page => 50})
    end
    respond_to do |format|
      format.html { @results = search.results }
    end
  end

end