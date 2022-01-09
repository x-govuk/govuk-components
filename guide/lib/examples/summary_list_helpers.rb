module Examples
  module SummaryListHelpers
    def summary_list_normal
      <<~SUMMARY_LIST
        = govuk_summary_list do |summary_list|
          - summary_list.row do |row|
            - row.key { 'Aardvark' }
            - row.value { 'The aardvark is vaguely pig-like in appearance' }
            - row.action(text: "Change", href: '#', visually_hidden_text: 'aardvarks')

          - summary_list.row do |row|
            - row.key(text: 'Baboon')
            - row.value(text: 'Monkeys of the genus Papio')
            - row.action(text: "Email", href: '#', visually_hidden_text: 'baboons')
            - row.action(text: "Change", href: '#', visually_hidden_text: 'baboons')

          - summary_list.row do |row|
            - row.key(text: 'Chinchilla')
            - row.value(text: 'Either of two species of crepuscular rodents')
            - row.action(text: 'Change', visually_hidden_text: 'chinchillas', href: '#')

          - summary_list.row do |row|
            - row.key(text: 'Dugong')
            - row.value(text: 'Dugongs are a species of sea cow')
      SUMMARY_LIST
    end

    def summary_list_without_actions
      <<~SUMMARY_LIST_WITHOUT_ACTIONS
        = govuk_summary_list(actions: false) do |summary_list|
          - summary_list.row do |row|
            - row.key { 'Name' }
            - row.value { 'Sherlock Holmes' }

          - summary_list.row do |row|
            - row.key(text: 'Address')
            - row.value do
              | 221B Baker Street, Westminster, London, NW1 6XE, England

          - summary_list.row do |row|
            - row.key(text: 'Phone number')
            - row.value(text: '020 123 1234')
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
