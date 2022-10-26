class DsfrComponent::AlertComponent < DsfrComponent::Base
  attr_reader :title

  def initialize(title:, classes: [], html_attributes: {})
    @title = title

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(**html_attributes) do
      safe_join([title_tag, content_tag])
    end
  end

private

  def default_attributes
    { class: %w(fr-alert) }
  end

  def title_tag
    tag.h3(class: "fr-alert__title") { title }
  end

  def content_tag
    tag.p { content }
  end
end
