class GovukComponent::ExitThisPageComponent < GovukComponent::Base
  attr_reader :text, :redirect_url, :secondary

  def initialize(text: config.default_exit_this_page_text, redirect_url: config.default_exit_this_page_redirect_url, secondary: false, classes: [], html_attributes: {})
    @text = text
    @redirect_url = redirect_url
    @secondary = secondary

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    if secondary
      exit_this_page_content
    else
      tag.div(exit_this_page_content, **html_attributes)
    end
  end

private

  def exit_this_page_content
    return content if content.present?

    if secondary
      govuk_link_to(text, redirect_url, **link_attributes, **secondary_link_attributes)
    else
      govuk_button_link_to(text, redirect_url, **link_attributes)
    end
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

  def secondary_link_attributes
    { data: { module: "govuk-skip-link" } }
  end
end
