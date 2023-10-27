module GovukComponent
  class TaskListComponent < GovukComponent::Base
    renders_many :items, "GovukComponent::TaskListComponent::ItemComponent"

    def initialize(classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      tag.ul(**html_attributes) { safe_join(items) }
    end

  private

    def default_attributes
      { class: 'govuk-task-list' }
    end
  end
end
