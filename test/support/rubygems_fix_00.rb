# frozen_string_literal: true
# fix bug with Gem.datadir
# see: https://github.com/rubygems/rubygems/issues/1673

if Gem.rubygems_version.to_s =~ /2\.7\.\d+/
  module Gem
    class BasicSpecification
      undef :datadir if method_defined?(:datadir)
      def datadir
        File.join ".", "data", name
      end
    end
  end
end
