require 'spec_helper'

RSpec.describe(GovukComponent::ExitThisPageComponent, type: :component) do
  let(:component_css_class) { "govuk-exit-this-page" }

  subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

  specify "renders a div containing an 'Exit this page' link to BBC Weather" do
    expect(rendered_content).to have_tag("div", with: { class: component_css_class }) do
      with_tag("a", text: "Exit this page", with: { href: "https://www.bbc.co.uk/weather" })
    end
  end

  specify "the link is styled like a warning button" do
    expect(rendered_content).to have_tag("a", with: { class: %w(govuk-button govuk-button--warning) })
  end

  specify "the link has the govuk-exit-this-page classes" do
    expect(rendered_content).to have_tag("a", with: { class: %w(govuk-exit-this-page__button govuk-js-exit-this-page-button) })
  end

  context "when a block of content is passed in" do
    let(:custom_redirect_text) { "Leave this page" }
    let(:custom_redirect_url) { "https://www.wikipedia.org" }

    subject! do
      render_inline(GovukComponent::ExitThisPageComponent.new(redirect_url: custom_redirect_url)) do
        custom_redirect_text
      end
    end

    specify "the custom content is rendered in the div" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class }) do
        with_tag("a", text: custom_redirect_text, with: { href: custom_redirect_url })
      end
    end
  end

  describe "link arguments" do
    let(:custom_href) { "https://test.com" }

    context "when providing a redirect_url" do
      subject! { render_inline(GovukComponent::ExitThisPageComponent.new(redirect_url: custom_href)) }

      specify "renders a link with the provided href" do
        expect(rendered_content).to have_tag("a", with: { href: custom_href })
      end
    end

    context "when providing a href" do
      subject! { render_inline(GovukComponent::ExitThisPageComponent.new(href: custom_href)) }

      specify "renders a link with the provided href" do
        expect(rendered_content).to have_tag("a", with: { href: custom_href })
      end
    end

    context "when providing a href and a redirect_url" do
      specify "fails with an appropriate error message" do
        expect { render_inline(GovukComponent::ExitThisPageComponent.new(href: custom_href, redirect_url: custom_href)) }
          .to raise_error(ArgumentError, /either redirect_url or href, not both/)
      end
    end
  end
end
