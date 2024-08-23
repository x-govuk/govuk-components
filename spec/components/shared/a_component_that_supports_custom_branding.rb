shared_examples 'a component that supports custom branding' do
  let(:default_brand) { 'govuk' }
  let(:custom_brand) { 'globex-corp' }

  before do
    Govuk::Components.configure do |conf|
      conf.brand = custom_brand
    end
  end

  after do
    Govuk::Components.reset!
  end

  specify "should contain the custom branding" do
    render_inline(described_class.new(**kwargs))

    expect(rendered_content).to match(Regexp.new(custom_brand))
  end

  specify "should not contain any default branding" do
    render_inline(described_class.new(**kwargs))

    expect(rendered_content).not_to match(Regexp.new(default_brand))
  end
end

shared_examples 'a component that supports brand overrides' do
  let(:default_brand) { 'govuk' }
  let(:custom_brand) { 'carrington-institute' }

  before do
    class_name = defined?(component_class_name) ? component_class_name : described_class.name
    extra_classes = defined?(extra_overrides) ? extra_overrides.index_with(custom_brand) : {}

    Govuk::Components.configure do |conf|
      conf.brand_overrides = { class_name => custom_brand, **extra_classes }
    end
  end

  after do
    Govuk::Components.reset!
  end

  specify "should contain the custom branding" do
    render_inline(described_class.new(**kwargs))

    expect(rendered_content).to match(Regexp.new(custom_brand))
  end

  specify "should not contain any default branding" do
    render_inline(described_class.new(**kwargs))

    expect(rendered_content).not_to match(Regexp.new(default_brand))
  end
end
