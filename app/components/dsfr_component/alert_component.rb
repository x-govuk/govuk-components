class DsfrComponent::AlertComponent < DsfrComponent::Base
  attr_reader :title

  def initialize(title:, classes: [], html_attributes: {})
    @title = title

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.div(**html_attributes) do
      tag.h3(class: "fr-alert__title") { title }
      tag.p { content }
    end
  end

private

  def default_attributes
    { class: %w(fr-alert) }
  end
end
