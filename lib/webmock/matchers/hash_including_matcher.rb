module WebMock
  module Matchers
    #this is a based on RSpec::Mocks::ArgumentMatchers::HashIncludingMatcher
    #https://github.com/rspec/rspec-mocks/blob/master/lib/rspec/mocks/argument_matchers.rb
    class HashIncludingMatcher
      def initialize(expected)
        @expected = Hash[WebMock::Util::HashKeysStringifier.stringify_keys!(expected).sort]
      end

      def ==(actual)
        unless @expected.empty? 
          @expected.all? {|k,v| actual.has_key?(k) && v == actual[k]}
        else 
          actual.empty? 
        end
      rescue NoMethodError
        false
      end

      def inspect
        "hash_including(#{@expected.inspect})"
      end

      def self.from_rspec_matcher(matcher)
        new(matcher.instance_variable_get(:@expected))
      end
    end

    #this is a based on RSpec::Mocks::ArgumentMatchers::AnyArgMatcher
    class AnyArgMatcher
      def initialize(ignore)
      end

      def ==(other)
        true
      end
    end

  end
end
