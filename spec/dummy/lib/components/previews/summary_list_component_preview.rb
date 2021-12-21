class SummaryListComponentPreview < ViewComponent::Preview
  # @label Summary list
  #
  # Use the summary list to summarise information, for example, a user’s responses at the end of a form.
  def summary_list
    render GovukComponent::SummaryListComponent.new do |summary_list|
      summary_list.row do |row|
        row.key { 'Aardvark' }
        row.value { 'The aardvark is vaguely pig-like in appearance' }
        row.action(text: "Change", href: '#aardvark', classes: 'tubulidentata')
      end

      summary_list.row do |row|
        row.key(text: 'Baboon')
        row.value(text: 'Monkeys of the genus Papio')
        row.action(text: "Change", href: '#baboon', classes: 'papionini')
      end

      summary_list.row do |row|
        row.key(text: 'Chinchilla')
        row.value(text: 'Either of two species of crepuscular rodents')
        row.action(
          text: 'Change',
          visually_hidden_text: 'this rodent for a different kind',
          href: '#chinchilla',
          classes: 'caviomorpha'
        )
      end
    end
  end

  # @label Summary list without actions
  #
  # You can add actions to a summary list, like a ‘Change’ link to let users go back and edit their answer. 
  def summary_list_without_actions
    render GovukComponent::SummaryListComponent.new do |summary_list|
      summary_list.row do |row|
        row.key { 'Aardvark' }
        row.value { 'The aardvark is vaguely pig-like in appearance' }
      end

      summary_list.row do |row|
        row.key(text: 'Baboon')
        row.value(text: 'Monkeys of the genus Papio')
      end

      summary_list.row do |row|
        row.key(text: 'Chinchilla')
        row.value(text: 'Either of two species of crepuscular rodents')
      end
    end
  end

  # @label Summary list without borders
  #
  # You can omit borders using the borders argument
  def summary_list_without_borders
    render GovukComponent::SummaryListComponent.new(borders: false) do |summary_list|
      summary_list.row do |row|
        row.key { 'Aardvark' }
        row.value { 'The aardvark is vaguely pig-like in appearance' }
        row.action(text: "Change", href: '#aardvark', classes: 'tubulidentata')
      end

      summary_list.row do |row|
        row.key(text: 'Baboon')
        row.value(text: 'Monkeys of the genus Papio')
        row.action(text: "Change", href: '#baboon', classes: 'papionini')
      end

      summary_list.row do |row|
        row.key(text: 'Chinchilla')
        row.value(text: 'Either of two species of crepuscular rodents')
        row.action(
          text: 'Change',
          visually_hidden_text: 'this rodent for a different kind',
          href: '#chinchilla',
          classes: 'caviomorpha'
        )
      end
    end
  end

  # @label Summary list with custom classes and HTML attributes
  #
  def summary_list_without_borders
    render GovukComponent::SummaryListComponent.new(classes: "pink", html_attributes: { data: { controller: 'summary-list' } }) do |summary_list|
      summary_list.row do |row|
        row.key { 'Aardvark' }
        row.value { 'The aardvark is vaguely pig-like in appearance' }
        row.action(text: "Change", href: '#aardvark', classes: 'tubulidentata')
      end

      summary_list.row do |row|
        row.key(text: 'Baboon')
        row.value(text: 'Monkeys of the genus Papio')
        row.action(text: "Change", href: '#baboon', classes: 'papionini')
      end

      summary_list.row do |row|
        row.key(text: 'Chinchilla')
        row.value(text: 'Either of two species of crepuscular rodents')
        row.action(
          text: 'Change',
          visually_hidden_text: 'this rodent for a different kind',
          href: '#chinchilla',
          classes: 'caviomorpha'
        )
      end
    end
  end
end
