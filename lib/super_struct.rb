require "super_struct/version"

module SuperStruct
  module InstanceMethods
    def initialize(*input)
      if input.first.respond_to?(:has_key?)
        keys, values = input.first.sort.transpose
        unless keys.map(&:to_sym) == members
          raise ArgumentError.new("#{self.class.name} expects a hash with keys #{members.join(', ')}")
        end
        super(*values)
      else
        super(*input)
      end
    end

    def attributes
      members.inject({}) do |attributes, member|
        attributes[member] = send(member)
        attributes
      end
    end
  end

  def self.new(array_or_hash, &block)
    keys = if array_or_hash.respond_to?(:has_key?)
      array_or_hash.keys.sort.map(&:to_sym)
    else
      array_or_hash.sort.map(&:to_sym)
    end

    Struct.new(*keys, &block).tap do |struct|
      struct.send(:include, InstanceMethods)
    end
  end
end
