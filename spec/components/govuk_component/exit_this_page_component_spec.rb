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

  describe "secondary mode" do
    subject! { render_inline(GovukComponent::ExitThisPageComponent.new(secondary: true)) }

    specify "renders an 'Exit this page' link to BBC Weather" do
      expect(rendered_content).to have_tag("a", text: "Exit this page", with: { href: "https://www.bbc.co.uk/weather" })
    end

    specify "does not render a surrounding div" do
      expect(rendered_content).not_to have_tag("div")
    end

    specify "the link isn't styled like a button" do
      expect(rendered_content).to have_tag("a")
      expect(rendered_content).not_to have_tag("a", with: { class: "govuk-button" })
    end

    specify "the link has the govuk-skip-link data module" do
      expect(rendered_content).to have_tag("a", with: { "data-module" => "govuk-skip-link" })
    end
  end

  context "when a block of content is passed in" do
    let(:custom_redirect_text) { "Leave this page" }
    let(:custom_redirect_url) { "https://www.wikipedia.org" }

    subject! do
      render_inline(GovukComponent::ExitThisPageComponent.new) do
        helper.govuk_button_link_to(custom_redirect_text, custom_redirect_url, secondary: true)
      end
    end

    specify "the custom content is rendered in the div" do
      expect(rendered_content).to have_tag("div", with: { class: component_css_class }) do
        with_tag("a", text: custom_redirect_text, with: { href: custom_redirect_url, class: "govuk-button--secondary" })
      end
    end
  end
end
