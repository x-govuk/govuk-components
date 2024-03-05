module GovukListHelper
  def govuk_list(array = nil, type: nil, spaced: nil, classes: nil, html_attributes: {}, &block)
    type = type.to_s

    fail "Unrecognised type for govuk_list - should be :bullet or :number or nil" unless type.in?(["bullet", "number", ""])

    tag_type = (type == "number") ? "ol" : "ul"

    html_classes = ["#{brand}-list"]
    html_classes << "#{brand}-list--bullet" if type == "bullet"
    html_classes << "#{brand}-list--number" if type == "number"
    html_classes << "#{brand}-list--spaced" if spaced
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
