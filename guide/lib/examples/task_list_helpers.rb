module Examples
  module TaskListHelpers
    def default_task_list
      <<~SNIPPET
        = govuk_task_list(id_prefix: "project-tasks") do |task_list|
          - task_list.with_item(title: "Contact details", href: '#', status: "Completed")
          - task_list.with_item(title: "Project details", href: '#', status: "Completed")
          - task_list.with_item(title: "Funding",         href: '#', status: govuk_tag(text: "Incomplete", colour: "blue"))
      SNIPPET
    end

    def task_list_with_cannot_start_yet
      <<~SNIPPET
        = govuk_task_list(id_prefix: "project-tasks") do |task_list|
          - task_list.with_item(title: "Contact details", href: '#', status: "Completed")
          - task_list.with_item(title: "Project details", href: '#', status: "Completed")
          - task_list.with_item(title: "Funding", hint: "The funds will be announced on 1 April 2022") do |item|
            - item.with_status(text: "Cannot start yet", classes: "govuk-task-list__status--cannot-start-yet")
      SNIPPET
    end

    def task_list_with_coloured_tags
      <<~SNIPPET
        = govuk_task_list(id_prefix: "coloured-tags-example") do |task_list|
          - task_list.with_item(title: "Design", href: "#", status: govuk_tag(text: "Green", colour: "green"))
          - task_list.with_item(title: "Prototype", href: "#", status: govuk_tag(text: "Blue", colour: "blue"))
          - task_list.with_item(title: "Implementation", href: "#", status: govuk_tag(text: "Light blue", colour: "light-blue"))
          - task_list.with_item(title: "User acceptance testing", href: "#", status: govuk_tag(text: "Red", colour: "red"))
          - task_list.with_item(title: "Handover", href: "#") do |item|
            - item.with_status do
              = govuk_tag(text: "Turquoise", colour: "turquoise")
      SNIPPET
    end

    def task_list_with_hints
      <<~SNIPPET
        = govuk_task_list(id_prefix: "task-list-with-hints") do |task_list|
          - task_list.with_item(title: "Check your qualifications", hint: "You need GCSEs in English and maths", href: "#", status: govuk_tag(text: "Done", colour: "green"))

          - task_list.with_item do |item|
            - item.with_title(text: "Understand funding", hint: "Teacher training course fees are around £9,250 per year", href: "#")
            - item.with_status(text: govuk_tag(text: "Done", colour: "green"))

          - task_list.with_item do |item|
            - item.with_title(text: "Consider getting experience", hint: "Experiencing life in a school can help you decide if teaching is right for you", href: "#")
            - item.with_status(text: govuk_tag(text: "Arranged", colour: "yellow"))

          - task_list.with_item do |item|
            - item.with_title(text: "Find a teacher training course", hint: "Through teacher training you can get QTS, a PGCE, or both", href: "#")
            - item.with_status(text: govuk_tag(text: "To do", colour: "red"))
      SNIPPET
    end
  end
end
