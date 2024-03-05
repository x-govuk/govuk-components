module GovukListHelper
  def govuk_list(array = nil, type: nil, spaced: nil, classes: nil, html_attributes: {}, &block)
    html_classes = ["#{brand}-list"]

    case type.to_s.to_sym
    when :bullet
      html_classes << ["#{brand}-list--bullet"]
      tag_type = "ul"
    when :number
      html_classes << ["#{brand}-list--number"]
      tag_type = "ol"
    when :""
      tag_type = "ul"
    else
      raise "Unrecognised type for govuk_list - should be :bullet or :number or nil"
    end

    if spaced
      html_classes << ["#{brand}-list--spaced"]
    end

    html_classes += Array.wrap(classes)

    if block_given?
      content_tag(tag_type, class: html_classes, **html_attributes, &block)
    else
      content_tag(tag_type, class: html_classes, **html_attributes) do
        array.each do |item|
          concat tag.li(item)
        end
      end
    end
  end
end

ActiveSupport.on_load(:action_view) { include GovukListHelper }
