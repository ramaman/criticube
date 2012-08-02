class SearchController < ApplicationController

  def main
    @q = params[:q]
    # if @q && @q.length > 0
      search = Seek.main(params[:q], :paginate => {:page => params[:page], :per_page => 50}) 
    # end
    respond_to do |format|
      format.html { @results = search.results }
      format.json {
        render :json => search.results.map { |hit|
          if hit.class == User
            json_label = "#{hit.fast_name} (#{hit.page_name})"
            extra = 'User'
          elsif hit.class == Cube
            json_label = hit.name
            extra = 'Cube'
          end
          {
            :name => json_label, #+ "  - #{hit.class.to_s}",
            :path => hit.permalink,
            :extra => extra
          }
        }.as_json
      }
    end
  end

end