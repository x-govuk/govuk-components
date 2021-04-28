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
      component.body { body }
      component.actions { actions }
    end
  end

  specify "contains a cookies banner with the correct title, body text and actions" do
    expect(page).to have_css("h2", class: %w(govuk-cookie-banner__heading), text: title)

    expect(page).to have_css('.govuk-cookie-banner__content') do |body|
      expect(body).to have_content('An introductory paragraph.')
      expect(body).to have_content('A second paragraph.')
    end

    expect(page).to have_css('.govuk-button-group') do |actions|
      expect(actions).to have_button(value: 'Accept')
      expect(actions).to have_button(value: 'Reject')

      expect(actions).to have_link(text: 'View', href: '/view-path')
    end
  end

  context "custom aria labels" do
    let(:aria_label) { "Cookie section" }
    let(:kwargs) { { aria_label: aria_label } }

    specify "sets the aria-label correctly" do
      expect(page).to have_css(%(div.govuk-cookie-banner[aria-label="#{aria_label}"]))
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
