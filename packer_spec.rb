require 'minitest/autorun'
require './short_string_packer'

def random_string
  [*'a'..'z'].sample(rand(1..12)).join
end

test_cases = %w(a z asdf abcdefghijkl aaaaaazzzzzz)

describe 'Test whether packing methods are valid' do
  it 'should pack strings into numbers' do
    packed = ShortStringPacker.pack(random_string)
    packed.must_be_instance_of Fixnum
  end

  it 'should unpack numbers back into strings' do
    rand_packed = (rand * 10000000).to_i
    str = ShortStringPacker.unpack(rand_packed)
    str.must_be_instance_of String
  end
end

describe 'Test whether roundtripping of packing works' do
  test_cases.each do |str|
    it "should pack and unpack \'#{str}\' correctly" do
      packed = ShortStringPacker.pack(str)
      unpacked = ShortStringPacker.unpack(packed)
      unpacked.must_equal str
    end
  end
end
