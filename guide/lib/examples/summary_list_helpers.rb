module Examples
  module SummaryListHelpers
    def summary_list_normal
      <<~SUMMARY_LIST
        = govuk_summary_list do |summary_list|
          - summary_list.with_row do |row|
            - row.with_key { 'Aardvark' }
            - row.with_value { 'The aardvark is vaguely pig-like in appearance' }
            - row.with_action(text: "Change", href: '#', visually_hidden_text: 'aardvarks')

          - summary_list.with_row do |row|
            - row.with_key(text: 'Baboon')
            - row.with_value(text: 'Monkeys of the genus Papio')
            - row.with_action(text: "Email", href: '#', visually_hidden_text: 'baboons')
            - row.with_action(text: "Change", href: '#', visually_hidden_text: 'baboons')

          - summary_list.with_row do |row|
            - row.with_key(text: 'Chinchilla')
            - row.with_value(text: 'Either of two species of crepuscular rodents')
            - row.with_action(text: 'Change', visually_hidden_text: 'chinchillas', href: '#')

          - summary_list.with_row do |row|
            - row.with_key(text: 'Dugong')
            - row.with_value(text: 'Dugongs are a species of sea cow')
      SUMMARY_LIST
    end

    def summary_list_without_actions
      <<~SUMMARY_LIST_WITHOUT_ACTIONS
        = govuk_summary_list(actions: false) do |summary_list|
          - summary_list.with_row do |row|
            - row.with_key { 'Name' }
            - row.with_value { 'Sherlock Holmes' }

          - summary_list.with_row do |row|
            - row.with_key(text: 'Address')
            - row.with_value do
              | 221B Baker Street, Westminster, London, NW1 6XE, England

          - summary_list.with_row do |row|
            - row.with_key(text: 'Phone number')
            - row.with_value(text: '020 123 1234')
      SUMMARY_LIST_WITHOUT_ACTIONS
    end

    def summary_list_from_rows
      <<~SUMMARY_LIST_FROM_ROWS
        = govuk_summary_list(rows: rows)
      SUMMARY_LIST_FROM_ROWS
    end

    def summary_list_from_rows_data
      <<~SUMMARY_LIST_FROM_ROWS_DATA
        {
          rows: [
            { key: { text: "Name" }, value: { text: "Hercule Poirot" } },
            {
              key: { text: "Address" },
              value: { text: "Flat 203, 56B Whitehaven Mansions, Charterhouse Square, London" },
              actions: [{ href: "#", visually_hidden_text: "address" }]
            }
          ]
        }
      SUMMARY_LIST_FROM_ROWS_DATA
    end
  end
end
