module GovukComponent
  class TaskListComponent < GovukComponent::Base
    renders_many :items, ->(title: nil, href: nil, hint: nil, status: {}, classes: [], html_attributes: {}) do
      GovukComponent::TaskListComponent::ItemComponent.new(
        title:,
        href:,
        hint:,
        id_prefix: @id_prefix,
        count: @count,
        status:,
        classes:,
        html_attributes:
      )
    end

    def initialize(id_prefix: "task-list", classes: [], html_attributes: {})
      @id_prefix = id_prefix
      @count = 0

      super(classes:, html_attributes:)
    end

    def call
      numbered_items = items.each.with_index(1) { |item, count| item.count = count }

      tag.ul(**html_attributes) do
        safe_join(numbered_items)
      end
    end

  private

    def default_attributes
      { class: "#{brand}-task-list" }
    end
  end
end
