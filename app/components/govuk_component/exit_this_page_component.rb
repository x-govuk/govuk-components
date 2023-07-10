class GovukComponent::ExitThisPageComponent < GovukComponent::Base
  attr_reader :text, :redirect_url

  def initialize(text: config.default_exit_this_page_text, redirect_url: config.default_exit_this_page_redirect_url, classes: [], html_attributes: {})
    @text = text
    @redirect_url = redirect_url

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(exit_this_page_content, **html_attributes)
  end

private

  def exit_this_page_content
    content.presence || govuk_button_link_to(text, redirect_url, **link_attributes)
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
