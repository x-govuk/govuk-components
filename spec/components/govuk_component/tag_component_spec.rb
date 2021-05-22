require 'spec_helper'

RSpec.describe(GovukComponent::TagComponent, type: :component, version: 2) do
  include_context 'setup'

  let(:text) { 'Alert' }
  let(:kwargs) { { text: text } }
  let(:component_css_class) { 'govuk-tag' }

  describe 'content' do
    subject! { render_inline(GovukComponent::TagComponent.new(**kwargs)) }

    specify 'renders strong element with right class and text' do
      expect(rendered_component).to have_tag('strong', with: { class: component_css_class }, text: text)
    end
  end

  describe 'colours' do
    context 'when valid colours are provided' do
      subject! { render_inline(GovukComponent::TagComponent.new(**kwargs)) }

      GovukComponent::TagComponent::COLOURS.each do |colour|
        context %('colour: #{colour}') do
          let(:kwargs) { { text: text, colour: colour } }

          specify %(adds class .govuk-colour--#{colour}) do
            expect(rendered_component).to have_tag(
              'strong',
              with: { class: [component_css_class, "govuk-tag--#{colour}"] },
              text: text
            )
          end
        end
      end
    end

    context 'when invalid colours are provided' do
      let(:invalid_colour) { 'hotdog' }
      subject { render_inline(GovukComponent::TagComponent.new(text: text, colour: invalid_colour)) }

      specify %(raises an error when colour isn't supported) do
        expect { subject }.to raise_error(ArgumentError, /invalid tag colour/)
        expect { subject }.to raise_error(ArgumentError, /#{invalid_colour}/)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
