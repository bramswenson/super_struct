require 'spec_helper'

describe SuperStruct do
  let(:constructor_input)  { { foo: { fiz: :bang } } }
  let(:klass)              { SuperStruct.new(constructor_input) }
  let(:input)              { constructor_input }
  subject                  { klass.new(input) }

  describe '::new' do
    subject { klass }

    it 'creates a new Class' do
      expect(subject.class).to eq Class
    end

    it 'extends the new Class with the SuperStruct methods' do
      expect(subject.new).to respond_to :attributes
    end

    context 'given a block upon construction' do
      let(:klass) do
        SuperStruct.new(constructor_input) do
          def has_attribute?(attribute)
            members.include?(attribute.to_sym)
          end
        end
      end

      it 'extends the Class with the block' do
        expect(klass.new).to have_attribute :foo
      end
    end
  end

  describe '::from_hash' do
    it 'creates a class and instance from the input' do
      expect(SuperStruct.from_hash(input)).to be_a Struct
    end
  end

  describe '#new' do
    context 'given an array as input' do
      subject { ::SuperStruct.new(:foo, :biz).new(:bar, :bang) }

      it 'uses the array as keys' do
        expect(subject.foo).to eq :bang
      end
    end
  end

  describe '#attributes' do
    it 'is a hash of the attributes and their values' do
      expect(subject.attributes).to eq constructor_input
    end
  end

  describe '#deep_convert!' do
    it 'converts all hashes within itself to SuperStructs' do
      expect {
        subject.deep_convert!
      }.to change {
        subject.foo
      }.from(Hash).to(Struct)
    end
  end

  describe '#==' do
    it 'compares with attributes (not class since structs can be anonymous)' do
      expect(subject).to eq klass.new(input)
    end
  end
end
