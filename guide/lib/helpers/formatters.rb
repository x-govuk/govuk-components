module Helpers
  module Formatters
    def block_has_content?(block)
      block.call
    end

    def format_slim(raw, **args)
      # FIXME: not sure why when we're several
      #        blocks deep we need to unescape more
      #        than once
      beautify(
        CGI.unescapeHTML(
          CGI.unescapeHTML(
           Slim::Template.new(format: :html) { raw }.render(ActionView::Base.new("", [], []))
          )
        )
      )
    end

    def format_erb(raw)
      # NOTE: this is many different kinds of bad. Thankfully we're
      #       only using it for documentation purposes and it won't be
      #       displayed by default
      HtmlBeautifier.beautify(
        Slim::ERBConverter.new(
          disable_escape: true,
          disable_capture: true,
          generator: Temple::Generators::RailsOutputBuffer
        )
          .call(raw)
          .gsub(/ _slim_controls\d =/, "=")    # remove _slim_controlsX assignment (where X is an integer)
          .gsub(/do\n\s+%>/, "do %>")          # close blocks on the same line
          .gsub(/%><%/, "%>\n<%")              # ensure ERB tags are on separate lines
          .gsub(/<%= _slim_controls\d %>/, '') # remove _slim_controlsX var display, we've handled it above
          .gsub(/,\n/, ', ')                   # don't leave newlines between args, it breaks indentation
      )
    end

  private

    def beautify(html)
      # All tags except textarea appear to line up correctly when
      # newlines are placed after tags and before closing tags,
      # except textarea which we need to account for manually 😒
      HtmlBeautifier
        .beautify(
          html
            .gsub(">", ">\n")
            .gsub("\<\/", "\n\<\/")
            .gsub(/>\s+<\/textarea>/, "></textarea>")
            .strip
        )
    end
  end
end
