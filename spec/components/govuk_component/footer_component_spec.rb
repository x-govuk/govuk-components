require 'spec_helper'

RSpec.describe(DsfrComponent::FooterComponent, type: :component) do
  let(:component_css_class) { "govuk-footer" }
  let(:custom_content) { "The quick brown fox" }
  let(:heading_text) { "Some title" }
  let(:kwargs) { {} }
  let(:meta_items_title) { 'Useful things' }
  let(:meta_licence) { 'MIT' }
  let(:selector) { "footer.govuk-footer .govuk-width-container .govuk-footer__meta" }

  let(:default_licence_text) { /All content is available under/ }

  let(:meta_items) do
    { one: '/one', two: '/two', three: '/three' }
  end

  subject! do
    render_inline(DsfrComponent::FooterComponent.new(**kwargs))
  end

  specify 'renders a footer element' do
    expect(rendered_content).to have_tag("footer", with: { class: component_css_class })
  end

  specify 'the footer contains licencing information and a link to the OGL licence' do
    expected_link = "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/"

    expect(rendered_content).to have_tag('footer', with: { class: 'govuk-footer' }) do
      with_tag('div', with: { class: 'govuk-footer__meta' }) do
        with_tag('span', with: { class: 'govuk-footer__licence-description' }, text: default_licence_text) do
          with_tag('a', with: { href: expected_link }, text: "Open Government Licence v3.0")
        end
      end
    end
  end

  specify 'the OGL logo is present' do
    expect(rendered_content).to have_tag('footer', with: { class: component_css_class }) do
      with_tag("div", with: { class: "govuk-footer__meta" }) do
        with_tag("svg", with: { class: "govuk-footer__licence-logo", 'aria-hidden' => true })
      end
    end
  end

  specify "the copyright information is present" do
    expect(rendered_content).to have_tag(selector) do
      with_tag("div", with: { class: "govuk-footer__meta-item" }, text: /Crown copyright/)
      with_tag("a", with: { class: %w(govuk-footer__link govuk-footer__copyright-logo) })
    end
  end

  describe "meta contents" do
    describe "items and title" do
      context "when no meta_items are provided" do
        let(:kwargs) { { meta_items_title: heading_text } }

        specify "no title should be rendered" do
          expect(rendered_content).not_to have_tag("h2", text: heading_text)
        end

        specify "no list should be rendered" do
          expect(rendered_content).not_to have_tag(".govuk-footer__inline-list")
        end
      end

      context "when meta items are provided" do
        let(:kwargs) { { meta_items_title: heading_text, meta_items: meta_items } }

        specify "the title should be rendered but visually hidden" do
          expect(rendered_content).to have_tag("h2", text: heading_text, with: { class: "govuk-visually-hidden" })
        end

        specify "each meta item is listed" do
          expect(rendered_content).to have_tag(selector) do
            with_tag("li > a", count: meta_items.size)

            meta_items.each do |text, href|
              with_tag("li", with: { class: "govuk-footer__inline-list-item" }) do
                with_tag("a", with: { href: href }, text: text)
              end
            end
          end
        end
      end

      context "when meta items are provided as an array of hashes" do
        let(:meta_items) do
          [
            { text: "One", href: "/one", attr: { a: "one" } },
            { text: "Two", href: "/two", attr: { b: "two" } },
            { text: "Three", href: "/two" }
          ]
        end
        let(:kwargs) { { meta_items_title: heading_text, meta_items: meta_items } }

        specify "each meta item is rendered" do
          expect(rendered_content).to have_tag(selector) do
            with_tag("li > a", count: meta_items.size)

            meta_items.each do |item|
              with_tag("li", with: { class: "govuk-footer__inline-list-item" }) do
                expected_attributes = { href: item[:href] }.merge(item.fetch(:attr, {}))

                with_tag("a", with: expected_attributes, text: item[:text])
              end
            end
          end
        end
      end

      context "when invalid meta items are provided" do
        specify "raises an error" do
          expect { DsfrComponent::FooterComponent.new(meta_items: "invalid") }.to raise_error(ArgumentError, "meta links must be a hash or array of hashes")
        end
      end
    end

    describe "custom meta_licence text" do
      let(:licence_text) { "Permission is hereby granted, free of charge, to any person obtaining a copy of this software" }
      let(:kwargs) { { meta_licence: licence_text } }
      let(:licence_selector) { [selector, ".govuk-footer__licence-description"].join(" ") }

      specify "the custom licence text should be rendered" do
        expect(rendered_content).to have_tag(licence_selector, text: licence_text)
      end

      specify "the licence SVG is not rendered" do
        expect(rendered_content).to have_tag("footer", with: { class: "govuk-footer" }) do
          with_tag("div", with: { class: "govuk-footer__meta" }) do
            without_tag("svg")
          end
        end
      end
    end

    describe "custom container classes" do
      let(:custom_container_classes) { %w(polka dots) }
      let(:kwargs) { { container_classes: custom_container_classes } }

      specify "should set the custom container classes" do
        expect(rendered_content).to have_tag("div", with: { class: custom_container_classes.append('govuk-width-container') })
      end
    end

    describe "custom container HTML attributes" do
      let(:custom_id) { "abc123" }
      let(:custom_container_html_attributes) { { id: custom_id } }
      let(:kwargs) { { container_html_attributes: custom_container_html_attributes } }

      specify "should set the custom container classes" do
        expect(rendered_content).to have_tag("div", with: { id: custom_id, class: "govuk-width-container" })
      end
    end

    describe "when custom meta_licence text is disabled" do
      let(:kwargs) { { meta_licence: false } }
      let(:licence_selector) { [selector, ".govuk-footer__licence-description"].join(" ") }

      specify "the licence text not should be rendered" do
        expect(rendered_content).not_to have_tag(licence_selector)
      end
    end

    describe "adding custom content under the meta items list" do
      let(:kwargs) { { meta_items_title: heading_text, meta_items: meta_items } }

      subject! do
        render_inline(DsfrComponent::FooterComponent.new(**kwargs)) do |footer|
          footer.meta_html { custom_content }
        end
      end

      specify "the content should be rendered" do
        expect(rendered_content).to have_tag(selector, text: Regexp.new(custom_content))
      end

      specify "the licence, meta items and header should still be rendered" do
        expect(rendered_content).to have_tag(selector) do
          with_tag("h2", text: heading_text)
          with_tag("ul", with: { class: "govuk-footer__inline-list" })
          with_tag("span", with: { class: "govuk-footer__licence-description" }, text: default_licence_text)
        end
      end
    end

    describe "custom meta contents" do
      describe "meta_text" do
        let(:custom_text) { "Some meta text" }

        subject! { render_inline(DsfrComponent::FooterComponent.new(meta_text: custom_text, **kwargs)) }

        specify "custom text is rendered" do
          expect(rendered_content).to have_tag("div", with: { class: "govuk-footer__meta-item" }) do
            with_tag('div', with: { class: "govuk-footer__meta-custom" }) do
              with_text(Regexp.new(custom_text))
            end
          end
        end
      end

      describe "meta_html" do
        let(:custom_text) { "Some meta html" }
        let(:custom_tag) { "span" }
        let(:custom_html) { helper.content_tag(custom_tag, custom_text) }

        subject! do
          render_inline(DsfrComponent::FooterComponent.new(**kwargs)) do |component|
            component.meta_html { custom_html }
          end
        end

        specify "custom HTML is rendered" do
          expect(rendered_content).to have_tag("div", with: { class: "govuk-footer__meta-item" }) do
            with_tag('div', with: { class: "govuk-footer__meta-custom" }) do
              with_tag(custom_tag, text: Regexp.new(custom_text))
            end
          end
        end
      end
    end
  end

  describe "overwriting all meta information entirely with custom content" do
    let(:kwargs) { { meta_items_title: heading_text, meta_items: meta_items } }

    subject! do
      render_inline(DsfrComponent::FooterComponent.new(**kwargs)) do |footer|
        footer.meta { custom_content }
      end
    end

    specify "the custom content should be rendered" do
      expect(rendered_content).to have_tag(selector, text: Regexp.new(custom_content))
    end

    specify "the licence, meta items and header shouldn't be rendered" do
      expect(rendered_content).to have_tag(selector) do
        without_tag("h2")
        without_tag("ul")
        without_tag("span")
      end
    end
  end

  describe "replacing the default copyright information" do
    let(:copyright_text) { "Copyright goes here" }
    let(:copyright_url) { "https://www.copyright.info" }
    let(:kwargs) { { copyright_text: copyright_text, copyright_url: copyright_url } }

    specify "the custom copyright text and link are rendered" do
      expect(rendered_content).to have_tag(selector) do
        with_tag("div", with: { class: "govuk-footer__meta-item" }, text: Regexp.new(copyright_text))
        with_tag("a", text: copyright_text, with: { href: copyright_url })
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  describe "navigation" do
    let(:custom_text) { "Some meta html" }
    let(:custom_tag) { "span" }
    let(:custom_html) { helper.content_tag(custom_tag, custom_text) }

    subject! do
      render_inline(DsfrComponent::FooterComponent.new(**kwargs)) do |component|
        component.navigation { custom_html }
      end
    end

    specify "custom HTML is rendered" do
      expect(rendered_content).to have_tag("div", with: { class: "govuk-footer__navigation" }) do
        with_tag(custom_tag, text: Regexp.new(custom_text))
      end
    end
  end
end
