class DemosController < ApplicationController
  def index
    # @partial_names = Dir
    #   .glob(Rails.root.join('app', 'views', 'demos', 'examples', '*.html.erb'))
    #   .map { |f| File.basename(f)[%r{_(?<partial>.*)\.html.erb}, %(partial)] }
    #   .sort

    @partial_names = ["alert"]
  end
end
