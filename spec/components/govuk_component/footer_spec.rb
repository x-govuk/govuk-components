require 'spec_helper'

RSpec.describe(GovukComponent::Footer, type: :component) do
  include_context 'helpers'

  let(:custom_copyright) { "All rights reserved" }
  let(:custom_copyright_url) { "https://en.wikipedia.org/wiki/All_rights_reserved" }
  let(:custom_licence_url) { "https://mit-license.org/" }
  let(:custom_licence) do
    %(Licenced under the <a href="#{custom_licence_url}">MIT Licence</a>.)
  end
  let(:custom_licence_text) { %(Licenced under the MIT Licence) }
  let(:kwargs) do
    { licence: custom_licence, copyright_text: custom_copyright, copyright_url: custom_copyright_url }
  end

  subject! do
    render_inline(GovukComponent::Footer.new(**kwargs))
  end

  context 'when no arguments are supplied' do
    subject! { render_inline(GovukComponent::Footer.new) }

    specify 'the default licence info is included' do
      expect(page).to have_css('footer.govuk-footer .govuk-footer__meta') do |footer|
        expect(footer).to have_css('.govuk-footer__licence-description') do |description|
          expect(description).to have_content(/All content is available under/)
          expect(description).to have_link("Open Government Licence v3.0", { href: "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", class: "govuk-footer__link" })
        end
      end
    end

    specify 'the default copyright information is included' do
      expect(page).to have_css('footer.govuk-footer .govuk-footer__meta') do |footer|
        expect(footer).to have_css('.govuk-footer__meta-item', text: %r{\&copy Crown copyright})
      end
    end

    specify 'the crown symbol is included' do
      expect(page).to have_css('footer.govuk-footer .govuk-footer__meta') do |footer|
        expect(footer).to have_css('svg', class: 'govuk-footer__licence-logo')
      end
    end
  end

  context 'when custom licence and copyright info are supplied' do
    specify 'the custom licence should have replaced the default' do
      expect(page).to have_css('footer.govuk-footer .govuk-footer__meta') do |footer|
        expect(footer).to have_css('.govuk-footer__licence-description') do |description|
          expect(description).to have_content(custom_licence_text)
          expect(description).to have_link("MIT Licence", href: custom_licence_url)

          expect(description).not_to have_content(/All content is available under/)
        end
      end
    end

    specify 'the custom copyright should have replaced the default' do
      expect(page).to have_css('footer.govuk-footer .govuk-footer__meta') do |footer|
        expect(footer).to have_css('.govuk-footer__meta-item') do
          expect(page).to have_link(custom_copyright, href: custom_copyright_url)
        end
      end
    end
  end

  context 'when custom content is passed in' do
    let(:content) do
      helper.tag.nav { helper.tag.h3('Navigation') }
    end

    subject! { render_inline(GovukComponent::Footer.new) { content } }

    specify 'the content should be rendered' do
      expect(page).to have_css('footer.govuk-footer') do |footer|
        expect(footer).to have_css('nav > h3', text: 'Navigation')
      end
    end
  end

  describe 'meta links' do
    subject! { render_inline(GovukComponent::Footer.new(meta_links: links, meta_heading: heading)) }

    context 'when meta links are supplied' do
      let(:heading) { 'Related info' }

      let(:links) do
        { one: '/one', two: '/two', three: '/three' }
      end

      specify { expect(page).to have_css('ul.govuk-footer__inline-list') }
      specify { expect(page).to have_css('h2', class: 'govuk-visually-hidden', text: heading) }

      specify 'the meta links should be rendered' do
        expect(page).to have_css('footer.govuk-footer .govuk-footer__meta') do |meta|
          expect(meta).to have_css('li', class: 'govuk-footer__inline-list-item', count: links.size)

          links.each do |text, href|
            expect(meta).to have_link(text, href: href)
          end
        end
      end
    end

    context 'when no meta links are supplied' do
      let(:links) { {} }
      let(:heading) { 'This should be absent' }

      specify { expect(page).not_to have_css('ul.govuk-footer__inline-list') }
      specify { expect(page).not_to have_css('h2', class: 'govuk-visually-hidden', text: heading) }
    end
  end

  context 'when the licence is suppressed' do
    let(:kwargs) { { show_licence: false } }

    specify { expect(page).not_to have_css("govuk-footer__licence-logo") }
    specify { expect(page).not_to have_css("govuk-footer__licence-description") }
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
