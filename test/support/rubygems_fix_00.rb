# frozen_string_literal: true

# fix bug with Gem.datadir
# see: https://github.com/rubygems/rubygems/issues/1673

if /2\.7\.\d+/.match?(Gem.rubygems_version.to_s)
  module Gem
    class BasicSpecification
      undef :datadir if method_defined?(:datadir)
      def datadir
        File.join ".", "data", name
      end
    end
  end
end
