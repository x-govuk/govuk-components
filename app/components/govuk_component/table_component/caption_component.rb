class GovukComponent::TableComponent::CaptionComponent < GovukComponent::Base
  attr_reader :text, :size

  SIZES = %w(s m l xl).freeze

  def initialize(text: nil, id: nil, size: 'm', classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @id   = id
    @text = text
    @size = size
  end

  def call
    tag.caption((content || text), class: classes, **html_attributes)
  end

private

  def default_classes
    %w(govuk-table__caption).tap do |c|
      c << caption_size_class if @size
    end
  end

  def caption_size_class
    fail(ArgumentError, "bad size #{size}, must be in #{SIZES}") unless size.in?(SIZES)

    %(govuk-table__caption--#{size})
  end
end
