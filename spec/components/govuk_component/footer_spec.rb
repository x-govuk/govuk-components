require 'spec_helper'

RSpec.describe(GovukComponent::Footer, type: :component) do
  include_context 'helpers'

  let(:custom_content) { "The quick brown fox" }
  let(:heading_text) { "Some title" }
  let(:kwargs) { {} }
  let(:meta_items_title) { 'Useful things' }
  let(:meta_licence) { 'MIT' }
  let(:selector) { "footer.govuk-footer .govuk-width-container .govuk-footer__meta" }

  let(:meta_items) do
    { one: '/one', two: '/two', three: '/three' }
  end

  subject! do
    render_inline(GovukComponent::Footer.new(**kwargs))
  end

  describe "when no arguments are provided" do
    specify 'the default licence info is included' do
      expect(page).to have_css('footer.govuk-footer .govuk-footer__meta') do |footer|
        expect(footer).to have_css('.govuk-footer__licence-description') do |description|
          expect(description).to have_content(/All content is available under/)
          expect(description).to have_link("Open Government Licence v3.0", { href: "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", class: "govuk-footer__link" })
        end
      end
    end

    specify 'the OGL logo is present' do
      expect(page).to have_css('footer.govuk-footer .govuk-footer__meta svg')
    end

    specify "the copyright information is present" do
      expect(page).to have_css([selector, ".govuk-footer__meta-item"].join(" "), text: /Crown copyright/)
      expect(page).to have_css([selector, ".govuk-footer__meta-item .govuk-footer__link.govuk-footer__copyright-logo"].join(" "))
    end
  end

  describe "custom meta contents" do
    let(:list_selector) { [selector, ".govuk-footer__inline-list"].join(" ") }

    describe "meta items and title" do
      let(:heading_selector) { [selector, "h2.govuk-visually-hidden"].join(" ") }

      context "when no meta_items are present" do
        let(:kwargs) { { meta_items_title: heading_text } }

        specify "no title should be rendered" do
          expect(page).not_to have_css(heading_selector, text: heading_text)
        end

        specify "no list should be rendered" do
          expect(page).not_to have_css(list_selector)
        end
      end

      context "when meta_items are present" do
        let(:kwargs) { { meta_items_title: heading_text, meta_items: meta_items } }
        let(:link_selector) { [selector, ".govuk-footer__inline-list", ".govuk-footer__inline-list-item a"].join(" ") }

        specify "the title should be rendered but visually hidden" do
          expect(page).to have_css(heading_selector, text: heading_text)
        end

        specify "each of the provided links is rendered in a list" do
          expect(page).to have_css(link_selector, count: meta_items.size)

          meta_items.each do |text, href|
            expect(page).to have_link(text, href: href)
          end
        end
      end
    end

    describe "when custom meta_licence text is provided" do
      let(:licence_text) { "Permission is hereby granted, free of charge, to any person obtaining a copy of this software" }
      let(:kwargs) { { meta_licence: licence_text } }
      let(:licence_selector) { [selector, ".govuk-footer__licence-description"].join(" ") }

      specify "the custom licence text should be rendered" do
        expect(page).to have_css(licence_selector, text: licence_text)
      end

      specify "the licence SVG is not rendered" do
        expect(page).not_to have_css('footer.govuk-footer .govuk-footer__meta svg')
      end
    end

    describe "when custom meta_licence text is disabled with nil" do
      let(:kwargs) { { meta_licence: false } }
      let(:licence_selector) { [selector, ".govuk-footer__licence-description"].join(" ") }

      specify "the licence text not should be rendered" do
        expect(page).not_to have_css(licence_selector)
      end
    end

    describe "adding custom content under the meta items list" do
      let(:kwargs) { { meta_items_title: heading_text, meta_items: meta_items } }

      subject! do
        render_inline(GovukComponent::Footer.new(**kwargs)) do |footer|
          footer.meta_content { custom_content }
        end
      end

      specify "the content should be rendered" do
        expect(page).to have_css(selector, text: custom_content)
      end

      specify "the licence, meta items and header should still be rendered" do
        expect(page).to have_css([selector, "h2"].join(" "))
        expect(page).to have_css([selector, ".govuk-footer__inline-list"].join(" "))
        expect(page).to have_css([selector, ".govuk-footer__licence-description"].join(" "))
      end
    end
  end

  describe "overwriting all meta information with custom content" do
    let(:kwargs) { { meta_items_title: heading_text, meta_items: meta_items } }

    subject! do
      render_inline(GovukComponent::Footer.new(**kwargs)) do |footer|
        footer.meta { custom_content }
      end
    end

    specify "the custom content should be rendered" do
      expect(page).to have_css(selector, text: custom_content)
    end

    specify "the licence, meta items and header shouldn't be rendered" do
      expect(page).not_to have_css([selector, "h2"].join(" "))
      expect(page).not_to have_css([selector, ".govuk-footer__inline-list"].join(" "))
      expect(page).not_to have_css([selector, ".govuk-footer__licence-description"].join(" "))
    end
  end

  describe "when custom copyright information is provided" do
    let(:copyright_text) { "Copyright goes here" }
    let(:copyright_url) { "https://www.copyright.info" }
    let(:kwargs) { { copyright_text: copyright_text, copyright_url: copyright_url } }

    specify "the custom copyright text and link are rendered" do
      expect(page).to have_css([selector, ".govuk-footer__meta-item"].join(" "), text: Regexp.new(copyright_text))
      expect(page).to have_link(copyright_text, href: copyright_url)
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end
