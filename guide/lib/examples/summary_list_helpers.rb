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
      SUMMARY_LIST
    end
  end
end
