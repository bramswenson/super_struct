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

    def deep_convert!
      members.each do |member|
        if self[member].respond_to?(:has_key?) && self[member].size > 0
          self[member] = ::SuperStruct.from_hash(self[member])
          self[member].deep_convert!
        end
      end
      self
    end

    def ==(other)
      other.respond_to?(:attributes) && attributes == other.attributes
    end
  end

  def self.new(*input, &block)
    keys = if input.first.respond_to?(:has_key?)
      input.first.keys.sort.map(&:to_sym)
    else
      input.sort.map(&:to_sym)
    end

    Struct.new(*keys, &block).tap do |struct|
      struct.send(:include, ::SuperStruct::InstanceMethods)
    end
  end

  def self.from_hash(hash, &block)
    new(hash, &block).new(hash)
  end
end
