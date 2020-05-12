require 'spec_helper'

RSpec.describe(GovukComponent::InsetText, type: :component) do
  let(:text) { 'Bake him away, toys.' }
  let(:component) { GovukComponent::InsetText.new(text: text) }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  specify 'contains a panel with the correct title and body text' do
    expect(subject).to have_css('div', class: %w(govuk-inset-text), text: text)
  end
end
