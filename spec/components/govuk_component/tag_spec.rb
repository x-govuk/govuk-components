require 'spec_helper'

RSpec.describe GovukComponent::Tag, type: :component do
  let(:text) { 'Alert' }
  let(:kwargs) { { text: text } }

  describe 'content' do
    subject! { render_inline(GovukComponent::Tag.new(**kwargs)) }

    specify 'should render a strong tag with the correct class and content' do
      expect(page).to have_css('strong.govuk-tag', text: text)
    end
  end

  describe 'colours' do
    context 'valid colours' do
      subject! { render_inline(GovukComponent::Tag.new(**kwargs)) }

      %w(
        grey green turquoise blue red
        purple pink orange yellow
      ).each do |colour|
        context colour do
          let(:kwargs) { { text: text, colour: colour } }

          specify %(.govuk-colour--#{colour} should be present) do
            expect(page).to have_css(%(strong.govuk-tag.govuk-tag--#{colour}), text: text)
          end
        end
      end
    end

    context 'invalid colours' do
      let(:invalid_colour) { 'hotdog' }
      subject { render_inline(GovukComponent::Tag.new(text: text, colour: invalid_colour)) }

      specify %(should raise an error when colour isn't supported) do
        expect { subject }.to raise_error(/invalid tag colour/)
        expect { subject }.to raise_error(/#{invalid_colour}/)
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

end
