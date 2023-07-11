class GovukComponent::ExitThisPageComponent < GovukComponent::Base
  attr_reader :text, :redirect_url

  def initialize(redirect_url: nil, href: nil, text: config.default_exit_this_page_text, classes: [], html_attributes: {})
    fail(ArgumentError, "provide either redirect_url or href, not both") if redirect_url.present? && href.present?

    @text = text
    @redirect_url = href || redirect_url || config.default_exit_this_page_redirect_url

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(exit_this_page_content, **html_attributes)
  end

private

  def exit_this_page_content
    govuk_button_link_to((content.presence || text), redirect_url, **link_attributes)
  end

  def default_attributes
    {
      class: "govuk-exit-this-page",
      data: { module: "govuk-exit-this-page" }
    }
  end

  def link_attributes
    {
      warning: true,
      class: %w(govuk-exit-this-page__button govuk-js-exit-this-page-button)
    }
  end
end
