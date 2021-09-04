module DummyLinks
  # Fake link_to for use in component previews
  def link_to(body, url, link_options = {})
    tag.a(body, href: url, **link_options)
  end
end
