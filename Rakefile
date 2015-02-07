require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :benchmark do
  require 'super_struct'
  require 'hashie'
  require 'ostruct'
  require 'benchmark'
  require 'benchmark/ips'

  class PORO
    attr_reader :foo, :bar, :baz

    def initialize attrs={}
      attrs.each do |attr, value|
        instance_variable_set "@#{attr}", value
      end
    end
  end

  attrs = { foo: 1, bar: true, baz: 'quux' }
  hashie = Hashie::Mash.new(attrs)
  struct_klass = Struct.new(*attrs.keys)
  struct = struct_klass.new(*attrs.values)
  ostruct = OpenStruct.new(attrs)
  poro = PORO.new(attrs)
  super_struct_klass = SuperStruct.new(attrs)
  super_struct = super_struct_klass.new(attrs)

  Benchmark.ips do |x|
    x.report 'Hashie alloc' do
      Hashie::Mash.new(attrs)
    end

    x.report 'Hash alloc' do
      Hash.new(attrs)
    end

    x.report 'OpenStruct alloc' do
      OpenStruct.new(attrs)
    end

    x.report 'PORO alloc' do
      PORO.new(attrs)
    end

    x.report 'Struct alloc' do
      struct_klass.new(*attrs.values)
    end

    x.report 'SuperStruct hash alloc' do
      super_struct_klass.new(attrs)
    end

    x.report 'SuperStruct array alloc' do
      super_struct_klass.new(*attrs.sort.map(&:last))
    end

    x.compare!
  end

  Benchmark.ips do |x|
    x.report 'Hashie access' do
      hashie.foo
      hashie.bar
      hashie.baz
    end

    x.report 'Hash access' do
      attrs[:foo]
      attrs[:bar]
      attrs[:baz]
    end

    x.report 'OStruct access' do
      ostruct.foo
      ostruct.bar
      ostruct.baz
    end

    x.report 'PORO access' do
      poro.foo
      poro.bar
      poro.baz
    end

    x.report 'Struct access' do
      struct.foo
      struct.bar
      struct.baz
    end

    x.report 'SuperStruct access' do
      super_struct.foo
      super_struct.bar
      super_struct.baz
    end

    x.compare!
  end
end
