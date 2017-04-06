# frozen_string_literal: true
# fix bug with Gem.datadir
# see: https://github.com/rubygems/rubygems/issues/1673

if Gem.rubygems_version.to_s =~ /2\.5\.\d+/
  module Gem
    class BasicSpecification
      undef :datadir if method_defined?(:datadir)
      def datadir
        File.join full_gem_path, "data", name
      end
    end
  end
end
