require "spec_helper"

RSpec.describe(GovukComponent::CookieBanner, type: :component) do
  include_context 'helpers'

  let(:title) { "Cookies on a service" }
  let(:body) do
    helper.safe_join(
      [
        helper.tag.p("An introductory paragraph."),
        helper.tag.p("A second paragraph."),
      ]
    )
  end
  let(:actions) do
    helper.safe_join(
      [
        helper.govuk_button_to("Accept", "/accept-path"),
        helper.govuk_button_to("Reject", "/reject-path"),
        helper.govuk_link_to("View", "/view-path"),
      ]
    )
  end
  let(:kwargs) { { title: title } }

  subject! do
    render_inline(described_class.new(**kwargs)) do |component|
      component.with(:body) { body }
      component.with(:actions) { actions }
    end
  end

  specify "contains a cookies banner with the correct title, body text and actions" do
    expect(page).to have_css("div", class: %w(govuk-cookie-banner)) do |banner|
      expect(banner).to have_css("h2", class: %w(govuk-cookie-banner__heading), text: title)
      within "div.govuk-cookie-banner__content" do
        expect(banner).to have_content(body)
      end
      within "div.govuk-button-group" do
        expect(banner).to have_content(actions)
      end
    end
  end

  context "when there is no title" do
    let(:kwargs) { {} }

    specify "renders the cookie banner without a title" do
      expect(page).to have_css("div", class: %w(govuk-cookie-banner))
      expect(page).not_to have_css(".govuk-cookie-banner__heading")
    end
  end

  it_behaves_like "a component that accepts custom classes"
  it_behaves_like "a component that accepts custom HTML attributes"
end
