class IndexController < ApplicationController
  def index
    @repositories = Repository.all.sort { |a,b| a.name.downcase <=> b.name.downcase }
    @latest = Count.order("record_date desc").limit(1).first

    response.headers['Cache-Control'] = 'public, max-age=300'
    respond_to do |format|
      format.html { render }
      format.csv  { 
        
        render :content_type => 'text/csv', :text =>  CsvExport.first.csv
      }
    end
  end

end
