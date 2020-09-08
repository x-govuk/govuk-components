require 'spec_helper'

RSpec.describe(GovukComponent::Layout::Column, type: :component) do
  include_context 'helpers'
  let(:expected_text) { 'Aloha' }
  let(:content) { helper.tag.span(expected_text) }

  supported_widths = {
    'full'           => 'govuk-grid-column-full',
    'one-half'       => 'govuk-grid-column-one-half',
    'two-thirds'     => 'govuk-grid-column-two-thirds',
    'one-third'      => 'govuk-grid-column-one-third',
    'three-quarters' => 'govuk-grid-column-three-quarters',
    'one-quarter'    => 'govuk-grid-column-one-quarter',
  }

  let(:supported_widths) { supported_widths }

  context 'when a width is supplied' do
    let(:kwargs) { { width: 'one-third' } }
    subject! do
      render_inline(GovukComponent::Layout::Column.new(**kwargs)) { content }
    end

    specify 'creates a div containing the provided content' do
      expect(page).to have_css('div > span', text: expected_text)
    end

    describe 'valid widths' do
      supported_widths.each do |name, klass|
        context %(width: '#{name}') do
          let(:kwargs) { { width: name } }

          specify %(element should have class #{klass}) do
            expect(page).to have_css(%(div.#{klass}))
          end
        end
      end
    end

    it_behaves_like 'a component that accepts custom classes'
    it_behaves_like 'a component that accepts custom HTML attributes'
  end

  context 'when a width from desktop is supplied' do
    let(:kwargs) { { width: 'one-third', from_desktop: 'one-half' } }
    subject! do
      render_inline(GovukComponent::Layout::Column.new(**kwargs)) { content }
    end

    specify 'creates a div containing the provided content' do
      expect(page).to have_css('div > span', text: expected_text)
    end

    describe 'valid widths from desktop' do
      supported_widths.each do |name, klass|
        context %(from_desktop: '#{name}') do
          let(:kwargs) { { width: 'one-third', from_desktop: name } }
          let(:expected_klass) { klass + '-from-desktop' }

          specify %(element should have class #{klass}-from-desktop) do
            expect(page).to have_css(%(div.#{expected_klass}))
          end
        end
      end
    end
  end

  describe 'bad widths' do
    subject { render_inline(GovukComponent::Layout::Column.new(**kwargs)) }

    context 'when no width is supplied' do
      let(:kwargs) { {} }

      specify 'raises with an appropriate message' do
        expect { subject }.to raise_error(/missing keyword/)
      end
    end

    context 'when an invalid width is supplied' do
      let(:invalid_width) { 'four-fifths' }
      let(:kwargs) { { width: invalid_width } }

      specify 'should raise an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError, /invalid width/)
      end
    end

    context 'when an invalid from desktop width is supplied' do
      let(:invalid_width) { 'four-fifths' }
      let(:kwargs) { { width: 'one-third', from_desktop: 'nine-eighths' } }

      specify 'should raise an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError, /invalid width/)
      end
    end
  end
end
