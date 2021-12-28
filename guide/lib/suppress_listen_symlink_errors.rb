require 'listen/record/symlink_detector'

# Taken from https://github.com/guard/listen/wiki/Duplicate-directory-errors
#
# Because we need to use a symlink to allow our Ruby Sass-c compilation to
# use sources from node_modules, Listen throws warnings and errors that
# the node_modules directory's already being watched.
#
# As this is a prototype and the warnings add noise to the logs, let's
# just ignore them altogether

module Listen
  class Record
    class SymlinkDetector
      def _fail(_, _)
        fail Error, "Don't watch locally-symlinked directory twice"
      end
    end
  end
end
