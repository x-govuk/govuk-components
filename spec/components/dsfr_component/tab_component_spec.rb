require 'spec_helper'

RSpec.describe(DsfrComponent::TabComponent, type: :component) do
  let(:title) { 'My favourite tabs' }
  let(:label) { 'A tab' }
  let(:component_css_class) { 'govuk-tabs' }

  let(:tabs) do
    {
      'tab 1' => 'first tab content',
      'tab 2' => 'second tab content',
      'tab 3' => 'third tab content'
    }
  end

  let(:kwargs) { { title: title } }

  subject! do
    render_inline(DsfrComponent::TabComponent.new(**kwargs)) do |component|
      tabs.each do |label, content|
        component.tab(label: label) { content }
      end
    end
  end

  let(:html) { Nokogiri.parse(rendered_content) }

  specify 'renders h2 element with right class and title' do
    expect(rendered_content).to have_tag(component_css_class_matcher) do
      with_tag('h2', with: { class: 'govuk-tabs__title' }, text: title)
    end
  end

  specify 'the right number of tabs are rendered' do
    expect(rendered_content).to have_tag('li', with: { class: 'govuk-tabs__list-item' }, count: tabs.size)
  end

  specify 'the tabs have the correct titles and hrefs' do
    tabs.each_key do |tab_title|
      expect(rendered_content).to(
        have_tag('a', with: { href: '#' + tab_title.parameterize }, text: tab_title)
      )
    end
  end

  specify 'only the first tab should be selected' do
    selected_tab_classes = %w(govuk-tabs__list-item govuk-tabs__list-item--selected)

    expect(rendered_content).to have_tag('li', with: { class: selected_tab_classes }, count: 1)
  end

  specify 'there is one panel per tab' do
    expect(rendered_content).to have_tag('div', with: { class: 'fr-tabs__panel' }, count: tabs.size)
  end

  specify 'each panel contains the right content' do
    tabs.each do |title, content|
      expect(rendered_content).to have_tag('div', with: { id: title.parameterize, class: 'fr-tabs__panel' }) do
        with_text(content)
      end
    end
  end

  specify 'first panel is shown, the rest are hidden' do
    visible_panel_id = tabs.keys.first.parameterize
    hidden_panel_ids = tabs.keys[1..].map(&:parameterize)

    expect(rendered_content).to have_tag('div', with: { id: visible_panel_id, class: 'fr-tabs__panel' })

    hidden_panel_ids.each do |hidden_panel_id|
      expect(rendered_content).to have_tag('div', with: { id: hidden_panel_id, class: %w(fr-tabs__panel fr-tabs__panel--hidden) })
    end
  end

  specify 'tabs are associated with the right panels' do
    tab_link_hrefs = html.css('a.govuk-tabs__tab').map { |tab| tab[:href].tr('#', '') }
    panel_ids = html.css('div.fr-tabs__panel').map { |panel| panel[:id] }

    expect(tab_link_hrefs).to eql(panel_ids)
  end

  context 'when a custom id is provided' do
    let(:custom_id) { 'abc-123' }
    let(:kwargs) { { title: "Some tabs", id: custom_id } }

    specify 'the tabs container has the specified id' do
      expect(rendered_content).to have_tag('div', with: { id: custom_id, class: component_css_class })
    end
  end

  context 'when text is passed to a tab instead of a block' do
    subject! do
      render_inline(DsfrComponent::TabComponent.new(**kwargs)) do |component|
        tabs.each do |label, content|
          component.tab(label: label, text: content)
        end
      end
    end

    specify 'each panel contains the right content' do
      tabs.each do |title, content|
        expect(rendered_content).to have_tag('div', with: { id: title.parameterize, class: 'fr-tabs__panel' }) do
          with_text(content)
        end
      end
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'

  context 'slot arguments' do
    let(:slot) { :tab }
    let(:content) { -> { 'some swanky tab content' } }
    let(:slot_kwargs) { { label: label } }

    it_behaves_like 'a component with a slot that accepts custom classes'
    it_behaves_like 'a component with a slot that accepts custom html attributes'
  end
end
