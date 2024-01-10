require 'spec_helper'

RSpec.describe(GovukComponent::ExitThisPageComponent, type: :component) do
  let(:component_css_class) { "govuk-exit-this-page" }
  let(:kwargs) { {} }

  subject! { render_inline(GovukComponent::ExitThisPageComponent.new(**kwargs)) }

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

  # Nokogiri's CSS selector doesn't seem to like dots in attribute names so
  # we'll have to drop down to finding the element and inspecting the elements
  # manually here
  describe "announcements" do
    let(:element) { html.at('div.govuk-exit-this-page') }

    describe "none" do
      specify "no data-i18n attributes are rendered" do
        expect(element.attributes.keys).not_to include(/data-i18n/)
      end
    end

    describe "activated_text" do
      let(:activated_text) { 'Exiting the page now' }
      let(:kwargs) { { activated_text: } }

      specify "adds the i18n data attribute for activated text" do
        expect(element.attributes["data-i18n.activated"].value).to eql(activated_text)
      end
    end

    describe "timed_out_text" do
      let(:timed_out_text) { 'Unfortunately Exit this page has expired.' }
      let(:kwargs) { { timed_out_text: } }

      specify "adds the i18n data attribute for timed out" do
        expect(element.attributes["data-i18n.timed-out"].value).to eql(timed_out_text)
      end
    end

    describe "press_two_more_times_text" do
      let(:press_two_more_times_text) { 'Shift, press 2 more times to leave.' }
      let(:kwargs) { { press_two_more_times_text: } }

      specify "adds the i18n data attribute for press two more times" do
        expect(element.attributes["data-i18n.press-two-more-times"].value).to eql(press_two_more_times_text)
      end
    end

    describe "press_one_more_time_text" do
      let(:press_one_more_time_text) { 'Shift, press 1 more times to leave.' }
      let(:kwargs) { { press_one_more_time_text: } }

      specify "adds the i18n data attribute for press one more time" do
        expect(element.attributes["data-i18n.press-one-more-time"].value).to eql(press_one_more_time_text)
      end
    end
  end

  it_behaves_like 'a component that supports custom branding'
end
