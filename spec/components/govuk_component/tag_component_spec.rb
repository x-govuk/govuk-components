require 'spec_helper'

RSpec.describe(GovukComponent::TagComponent, type: :component) do
  let(:text) { 'Alert' }
  let(:kwargs) { { text: } }
  let(:component_css_class) { 'govuk-tag' }

  describe 'content' do
    subject! { render_inline(GovukComponent::TagComponent.new(**kwargs)) }

    specify 'renders strong element with right class and text' do
      expect(rendered_content).to have_tag('strong', with: { class: component_css_class }, text:)
    end

    context 'when content is supplied in a block' do
      let(:custom_tag) { :mark }
      let(:custom_text) { "highlighted text" }
      let(:custom_class) { "orange" }

      subject! do
        render_inline(GovukComponent::TagComponent.new) do
          helper.content_tag(custom_tag, custom_text, class: custom_class)
        end
      end

      specify 'renders strong element with right class and text' do
        expect(rendered_content).to have_tag('strong', with: { class: component_css_class }) do
          with_tag(custom_tag, text: custom_text, with: { class: custom_class })
        end
      end
    end

    context 'when neither text or block content is supplied' do
      specify 'raises an appropriate error' do
        expect { render_inline(GovukComponent::TagComponent.new(colour: 'blue')) }.to raise_error(ArgumentError, /no text or content/)
      end
    end
  end

  describe 'colours' do
    context 'when valid colours are provided' do
      subject! { render_inline(GovukComponent::TagComponent.new(**kwargs)) }

      GovukComponent::TagComponent::COLOURS.each do |colour|
        context %('colour: #{colour}') do
          let(:kwargs) { { text:, colour: } }

          specify %(adds class .govuk-colour--#{colour}) do
            expect(rendered_content).to have_tag(
              'strong',
              with: { class: [component_css_class, "govuk-tag--#{colour}"] },
              text:
            )
          end
        end
      end
    end

    context 'when invalid colours are provided' do
      let(:invalid_colour) { 'hotdog' }
      subject { render_inline(GovukComponent::TagComponent.new(text:, colour: invalid_colour)) }

      specify %(raises an error when colour isn't supported) do
        expect { subject }.to raise_error(ArgumentError, /invalid tag colour/)
        expect { subject }.to raise_error(ArgumentError, /#{invalid_colour}/)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides' do
    let(:component_class) { "GovukComponent::TagComponent" }
  end
end
