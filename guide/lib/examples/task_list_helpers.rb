module Examples
  module TaskListHelpers
    def default_task_list
      <<~SNIPPET
        = govuk_task_list do |task_list|
          - task_list.with_item(title: "Contact details", href: '#', status: "Completed")
          - task_list.with_item(title: "Project details", href: '#', status: "Completed")
          - task_list.with_item(title: "Funding",         href: '#', status: govuk_tag(text: "Incomplete", colour: "blue"))
      SNIPPET
    end

    def task_list_with_coloured_tags
      <<~SNIPPET
        = govuk_task_list do |task_list|
          - task_list.with_item(title: "Design", status: govuk_tag(text: "Incomplete", colour: "green"))
          - task_list.with_item(title: "Prototype", status: govuk_tag(text: "Incomplete", colour: "blue"))
          - task_list.with_item(title: "Implementation", status: govuk_tag(text: "Incomplete", colour: "light-blue"))
          - task_list.with_item(title: "User acceptance testing", status: govuk_tag(text: "Incomplete", colour: "red"))
          - task_list.with_item(title: "Handover", status: govuk_tag(text: "Incomplete", colour: "turquoise"))
      SNIPPET
    end

    def task_list_with_data
      # TODO: demonstrate building a task list with an array of hashes
    end
  end
end
