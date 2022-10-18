require 'spec_helper'

RSpec.describe(DsfrComponent::BreadcrumbsComponent, type: :component) do
  let(:href) { 'https://www.gov.uk/government/organisations/department-for-education' }
  let(:link_text) { 'Organisations' }
  let(:breadcrumbs) { { link_text => href } }
  let(:kwargs) { { breadcrumbs: breadcrumbs } }
  let(:component_css_class) { 'govuk-breadcrumbs' }

  describe 'configuration' do
    after { Dsfr::Components.reset! }

    describe 'default_breadcrumbs_collapse_on_mobile' do
      let(:overridden_default_collapse_on_mobile) { true }
      let(:collapse_on_mobile_css_class) { 'govuk-breadcrumbs--collapse-on-mobile' }

      before do
        Dsfr::Components.configure do |config|
          config.default_breadcrumbs_collapse_on_mobile = overridden_default_collapse_on_mobile
        end
      end

      subject! { render_inline(DsfrComponent::BreadcrumbsComponent.new(**kwargs)) }

      specify 'renders the component with the correct class' do
        expect(rendered_content).to have_tag(
          'div',
          with: { class: [component_css_class, collapse_on_mobile_css_class] },
        ) do
          with_tag('a', text: link_text, with: { href: href })
        end
      end
    end

    describe 'default_breadcrumbs_hide_in_print' do
      let(:hide_in_print_css_class) { 'govuk-\!-display-none-print' }
      let(:overridden_default_hide_in_print) { true }

      before do
        Dsfr::Components.configure do |config|
          config.default_breadcrumbs_hide_in_print = overridden_default_hide_in_print
        end
      end

      subject! { render_inline(DsfrComponent::BreadcrumbsComponent.new(**kwargs)) }

      specify 'renders the component with the correct class' do
        expect(rendered_content).to have_tag(
          'div',
          with: { class: [component_css_class, hide_in_print_css_class] },
        ) do
          with_tag('a', text: link_text, with: { href: href })
        end
      end
    end
  end
end
