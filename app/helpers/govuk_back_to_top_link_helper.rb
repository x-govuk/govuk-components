module GovukBackToTopLinkHelper
  def govuk_back_to_top_link(target = '#top')
    link_to(target, class: "#{brand}-link #{brand}-link--no-visited-state") do
      <<-HTML.squish.html_safe
      <svg class="app-back-to-top__icon" xmlns="http://www.w3.org/2000/svg" width="13" height="17" viewBox="0 0 13 17">
        <path fill="currentColor" d="M6.5 0L0 6.5 1.4 8l4-4v12.7h2V4l4.3 4L13 6.4z"></path>
      </svg>
      Back to top
      HTML
    end
  end

private

  def brand
    Govuk::Components.brand
  end
end

ActiveSupport.on_load(:action_view) { include GovukBackToTopLinkHelper }
