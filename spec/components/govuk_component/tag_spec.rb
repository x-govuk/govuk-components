require 'spec_helper'

RSpec.describe Tag::TagComponent, type: :component do
  it 'should return the correct HTML' do
    component = Tag::TagComponent.new(text: 'Alert', colour: 'green')

    html = render_inline(component).to_html

    expect(html).to eql(<<~html
      <strong class="govuk-tag govuk-tag--green">
        Alert
      </strong>
      html
    )
  end
end
