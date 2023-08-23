module Examples
  module TaskListHelpers
    def default_task_list
      <<~SNIPPET
        = govuk_task_list do |task_list|
          - task_list.with_item(title: "Contact details", href: '#', status: "Done")
          - task_list.with_item(title: "Project details", href: '#', status: "Done")
          - task_list.with_item(title: "Funding",         href: '#', status: "Scheduled")
      SNIPPET
    end

    def task_list_with_coloured_tags
      <<~SNIPPET
        = govuk_task_list do |task_list|
          - task_list.with_item(title: "Design", status: { text: "Done", colour: "green" })
          - task_list.with_item(title: "Prototype", status: { text: "Done", colour: "green" })
          - task_list.with_item(title: "Implementation", status: { text: "In progress", colour: "yellow" })
          - task_list.with_item(title: "User acceptance testing", status: { text: "Postponed", colour: "purple" })
          - task_list.with_item(title: "Handover", status: { text: "Not yet started", colour: "red" })
      SNIPPET
    end

    def task_list_with_data
      # TODO: demonstrate building a task list with an array of hashes
    end
  end
end
