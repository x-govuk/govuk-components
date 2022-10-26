# Composants du DSFR

Cette gem fournit des composants pour le Design Système de l'État (DSFR) en s'appuyant sur le [framework ViewComponent](https://github.com/ViewComponent/view_component).

C'est un fork de [govuk-components](https://github.com/DFE-Digital/govuk-components) qui propose l'équivalent pour le GOV.UK Design System.

⚠️ Cette gem est en cours de développement et n'est pas adaptée à un usage en production. N'hésitez pas à contribuer pour nous aider à avancer !

<!--

[![Tests](https://github.com/DFE-Digital/govuk-components/workflows/Tests/badge.svg)](https://github.com/DFE-Digital/govuk-components/actions?query=workflow%3ATests)
[![Maintainability](https://api.codeclimate.com/v1/badges/cbcbc140f300b920d833/maintainability)](https://codeclimate.com/github/DFE-Digital/govuk-components/maintainability)
[![Gem Version](https://badge.fury.io/rb/govuk-components.svg)](https://badge.fury.io/rb/govuk-components)
[![Gem](https://img.shields.io/gem/dt/govuk-components?logo=rubygems)](https://rubygems.org/gems/govuk-components)
[![Test Coverage](https://api.codeclimate.com/v1/badges/cbcbc140f300b920d833/test_coverage)](https://codeclimate.com/github/DFE-Digital/govuk-components/test_coverage)
[![GitHub license](https://img.shields.io/github/license/DFE-Digital/govuk-components)](https://github.com/DFE-Digital/govuk-components/blob/main/LICENSE)
[![GOV.UK Design System Version](https://img.shields.io/badge/GOV.UK%20Design%20System-4.3.0-brightgreen)](https://design-system.service.gov.uk)
[![Rails](https://img.shields.io/badge/Rails-6.1.5%20%E2%95%B1%207.0.3-E16D6D)](https://weblog.rubyonrails.org/releases/)
[![Ruby](https://img.shields.io/badge/Ruby-2.7.6%20%20%E2%95%B1%203.0.3%20%20%E2%95%B1%203.1.2-E16D6D)](https://www.ruby-lang.org/en/downloads/)

This gem provides a suite of reusable components for the [GOV.UK Design System](https://design-system.service.gov.uk/). It is intended to provide a lightweight alternative to the [GOV.UK Publishing Components](https://github.com/alphagov/dsfr_publishing_components) library and is built with GitHub’s [ViewComponent](https://github.com/github/view_component) framework.

It aims to implement the functionality from the original Nunjucks macros in a way that will feel more familiar to Rails developers. Blocks are preferred over strings of HTML, beneath the surface each component is just a Ruby object, everything is inheritable and overrideable.

## Documentation

The gem comes with [a full guide](https://govuk-components.netlify.app/) that
covers most aspects of day-to-day use, along with code and output examples. The
examples in the guide (and the guide itself) are built using the components,
so it will always be up to date.

[![Netlify Status](https://api.netlify.com/api/v1/badges/d40a5a0a-b086-4c35-b046-97fbcbf9f219/deploy-status)](https://app.netlify.com/sites/govuk-components/deploys)

-->

## Composants disponibles

Cette gem a pour but de supporter tous les composants proposés par le Design Système de l'État hormis ceux concernant les formulaires. Ceux-ci seront fournis dans une gem indépendante dans le futur.

Les composants disponibles sont :

- [ ] Accordéon - Accordion
- [ ] Ajout de fichier - File upload
- [ ] Alertes - Alert
- [ ] Badge
- [ ] Bandeau d'information importante
- [ ] Barre de recherche - Search bar
- [ ] Boutons - Buttons
- [ ] Groupe de bouton
- [ ] Bouton FranceConnect
- [ ] Boutons radio
- [ ] Boutons radio 'riches'
- [ ] Case à cocher - Checkbox
- [ ] Cartes - Cards
- [ ] Champ de saisie - Input
- [ ] Citation - Quote
- [ ] Contenu médias - Responsive médias
- [ ] En-tête - Header
- [ ] Fil d'Ariane - Breadcrumb
- [ ] Gestionnaire de consentement - Consent banner
- [ ] Icônes de favoris - Favicons
- [ ] Indicateur d'étape
- [ ] Interrupteur - Toggle switch
- [ ] Lettre d'information et réseaux sociaux - Newsletter &amp; Follow us
- [ ] Liens - Links
- [ ] Liens d'évitement - Skiplinks
- [ ] Liste déroulante - Select
- [ ] Menu latéral - Side menu
- [ ] Mise en avant - Call out
- [ ] Mise en exergue - Highlight
- [ ] Modale - Modal
- [ ] Navigation principale - Main navigation
- [ ] Onglets - Tabs
- [ ] Pagination
- [ ] Paramètres d'affichage - Display
- [ ] Partage - Share
- [ ] Pied de page - Footer
- [ ] Sélecteur de langue
- [ ] Sommaire - Summary
- [ ] Tableau - Table
- [ ] Tag
- [ ] Téléchargement de fichier
- [ ] Tuile - Tile

<!--
This library also provides helpers for creating [links](https://govuk-components.netlify.app/helpers/link),
[buttons](https://govuk-components.netlify.app/helpers/button), [skip links](https://govuk-components.netlify.app/helpers/skip-link)
and [back to top links](https://govuk-components.netlify.app/helpers/back-to-top-link).
-->

<!--
## Alternative syntax

All of the components can be rendered in two ways:

* directly using Rails’ `#render` method:

  ```erb
    <%= render DsfrComponent::WarningTextComponent.new do %>
      A serious warning
    <% end %>
  ```

* via the helper wrapper:

  ```erb
    <%= dsfr_warning_text do %>
      A serious warning
    <% end %>
  ```

  The naming convention for helpers is `dsfr_` followed by the component’s name in snake case. You can see the full list in [DsfrComponentsHelper](app/helpers/dsfr_components_helper.rb).

## Example use

This library allows components to be rendered with Rails’ `render` method or via the provided helpers. Here we’ll use the `dsfr_tabs` to render three tabbed sections:

```erb
<%= dsfr_tabs(title: 'Days of the week') do |component| %>
  <% component.tab(label: 'Monday') do %>
    <p>Monday’s child is fair of face</p>
  <% end %>

  <% component.tab(label: 'Tuesday') do %>
    <p>Tuesday’s child is full of grace</p>
  <% end %>

  <% component.tab(label: 'Wednesday') do %>
    <p>Wednesday’s child is full of woe</p>
  <% end %>
<% end %>
```

Here are the rendered tabs:

![Tabs preview](docs/images/tabs.png)

For examples on usage see the [guide page](https://govuk-components.netlify.app/).

## Setup

Add this line to your `config/application.rb`:

```ruby
require "govuk/components"
```

## Services using this library

* [Apply for teacher training](https://github.com/DFE-Digital/apply-for-teacher-training)
* [Find postgraduate teacher training](https://github.com/DFE-Digital/find-teacher-training)
* [Get help with technology](https://github.com/DFE-Digital/get-help-with-tech)
* [Publish teacher training courses](https://github.com/DFE-Digital/publish-teacher-training)
* [Register trainee teachers](https://github.com/DFE-Digital/register-trainee-teachers)
* [Teaching Vacancies](https://github.com/DFE-Digital/teaching-vacancies)

## Installation

Ajouter cette ligne à votre Gemfile:

```ruby
gem 'dsfr-components'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install govuk-components
```
-->

## Contribuer

Nous conseillons d'utiliser [rbenv](https://github.com/rbenv/rbenv) pour gérer vos versions de ruby :

```sh
rbenv local 3.1.2
rbenv install
```

Lancer les tests :

```sh
bundle install
bundle exec rspec spec
```

Lancer la dummy app pour itérer sur les composants :

```sh
cd spec/dummy
bundle install && npm install
bundle exec rails server
```

Déployer une nouvelle version de la gem :

TODO

## Licence

Le code source et la gem sont ouverts sous la licence [MIT](https://opensource.org/licenses/MIT).
