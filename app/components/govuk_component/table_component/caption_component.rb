class GovukComponent::TableComponent::CaptionComponent < GovukComponent::Base
  attr_reader :text, :size

  SIZES = %w(s m l xl).freeze

  def initialize(text: nil, id: nil, size: 'm', classes: [], html_attributes: {})
    @id   = id
    @text = text
    @size = size

    super(classes: classes, html_attributes: html_attributes)
  end

  def call
    tag.caption(caption_content, **html_attributes)
  end

  def render?
    caption_content.present?
  end

private

  def caption_content
    @caption_content ||= (content || text)
  end

  def default_attributes
    { class: class_names("#{brand}-table__caption", caption_size_class => size).split }
  end

  def caption_size_class
    fail(ArgumentError, "bad size #{size}, must be in #{SIZES}") unless size.in?(SIZES)

    "#{brand}-table__caption--#{size}"
  end
end
