class DemosController < ApplicationController
  def show
    @partials = Dir
      .glob(Rails.root.join('app', 'views', 'demos', 'examples', '*.html.erb'))
      .map { |f| File.basename(f)[%r{_(?<partial>.*)\.html.erb}, %(partial)] }
      .sort
  end
end
