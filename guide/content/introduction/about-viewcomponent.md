---
title: About ViewComponent
---

[ViewComponent](https://viewcomponent.org/) is a framework
for Ruby on Rails that lets us build and share reusable components.

Compared to building the equivalent functionality using Rails' partials and
helpers, view components are:

* easy to test as both the logic and rendered HTML can be examined individually
* easier to understand than partials as they are backed by a Ruby object
* incredibly efficient, [up to 10 times faster than partials](https://viewcomponent.org/#performance)

## Slots

Some components contain elements that are repeated one or many times. For
example, the [header component can display multiple navigation
items](/components/header/#header-with-navigation-items). These are
implemented using
[ViewComponent's Slot API](https://viewcomponent.org/guide/slots.html).

Slots are view components that belong to other view components. For example,
the [table component](/components/table) has many rows and each row can have
many cells.

Slots are called by opening a block when rendering the component and calling
the slot by name against the object. In this example we have a shopping list
with several items:

```language-slim
/ with arguments:
= render(ShoppingList.new(items: ["Apple juice", "Bread", "Carrots"])

/ with slots:
= render(ShoppingList.new) do |shopping_list|
  - shopping_list.with_item("Apple juice")
  - shopping_list.with_item("Bread")
  - shopping_list.with_item("Carrots")
```

Slots give us more flexibilty. In this scenario they'd make it easier to
add logic to the list, or to add other arguments to each list item.

```language-slim
= render(ShoppingList.new) do |shopping_list|
  - shopping_list.with_item(count: 3)
    | Apple juice

  - shopping_list.with_item("Bread", sliced: true)

  - if cupboard.carrots.count == 0
    - shopping_list.with_item("Carrots")
```
