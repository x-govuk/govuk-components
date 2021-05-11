require 'spec_helper'

RSpec.describe(GovukComponent::Tabs, type: :component) do
  include_context 'helpers'

  let(:title) { 'My favourite tabs' }

  let(:tabs) do
    {
      'tab 1' => 'first tab content',
      'tab 2' => 'second tab content',
      'tab 3' => 'third tab content'
    }
  end

  let(:kwargs) { { title: title } }

  subject! do
    render_inline(GovukComponent::Tabs.new(**kwargs)) do |component|
      tabs.each do |title, content|
        component.tab(title: title) { content }
      end
    end
  end

  specify 'the tabs list should have the correct title' do
    expect(page).to have_css('.govuk-tabs') do |govuk_tabs|
      expect(govuk_tabs).to have_css('h2.govuk-tabs__title', text: title)
    end
  end

  specify 'there should be the correct number of tabs' do
    expect(page).to have_css('.govuk-tabs__list-item', count: tabs.size)
  end

  specify 'the tabs should have the correct titles and hrefs' do
    tabs.keys.each { |tab_title| expect(page).to have_link(tab_title, href: '#' + tab_title.parameterize) }
  end

  specify 'only the first tab should be selected' do
    selected_tab_classes = '.govuk-tabs__list-item.govuk-tabs__list-item--selected'

    expect(page).to have_css(selected_tab_classes, text: tabs.keys.first)
    expect(page).to have_css(selected_tab_classes, count: 1)
  end

  specify 'there should be one panel per tab' do
    expect(page).to have_css('.govuk-tabs__panel', count: tabs.size)
  end

  specify 'each panel should contain the correct content' do
    tabs.each do |title, content|
      expect(page).to have_css(%(##{title.parameterize}.govuk-tabs__panel)) do |panel|
        expect(panel).to have_content(content)
      end
    end
  end

  specify 'all panels except the first should be hidden' do
    visible_panel_id = tabs.keys.first.parameterize
    hidden_panel_ids = tabs.keys[1..].map(&:parameterize)

    expect(page).to have_css(%(##{visible_panel_id}.govuk-tabs__panel))

    hidden_panel_ids.each do |hidden_panel_id|
      expect(page).to have_css(%(##{hidden_panel_id}.govuk-tabs__panel.govuk-tabs__panel--hidden))
    end
  end

  specify 'tab link references and panel ids should correspond' do
    tab_link_hrefs = page.all('a.govuk-tabs__tab').map { |tab| tab[:href].tr('#', '') }
    panel_ids = page.all('div.govuk-tabs__panel').map { |panel| panel[:id] }

    expect(tab_link_hrefs).to eql(panel_ids)
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :tab }
    let(:content) { -> { 'some swanky tab content' } }
    let(:slot_kwargs) { { title: title } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'
  end

  it_behaves_like 'a component with a DSL wrapper' do
    let(:helper_name) { 'govuk_tabs' }
    let(:wrapped_slots) { %i(tab) }
    let(:block) { nil }

    let(:expected_css) { '.govuk-tabs' }
  end
end
