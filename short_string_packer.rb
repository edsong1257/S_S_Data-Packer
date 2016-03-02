class ShortStringPacker
  ## Packs a short string into a Fixnum
  # Arguments:
  #   str - String object
  # Returns: a Fixnum object
  def self.pack(str)
      # we use 5 bits to store a char, we can fit 12 chars(60bit) without overflow(62bit)
      max_length = (0.size << 3) / 5
      # 0x1A = 26, a NULL char, to distingush "a" and nothing
      return ( ([0x1A] * (max_length - str.length)) + str.chars.map{|c| c.ord - 'a'.ord}).inject do|memo, c|
        memo << 5 | c
      end
    end

  ## Unpacks a Fixnum from pack() method into a short string
  # Arguments:
  #   packed - a Fixnum object
  # Returns: a String object
  def self.unpack(packed)

    # add missing 0s
    bits = packed.to_s(2).rjust((packed.size << 3) - (packed.size << 3) % 5, '0')
    bits.chars.each_slice(5).map(&:join).map do |c|
      c = c.to_i(2)
      c == 0x1A ? '' : ('a'.ord + c).chr
    end.join
  end
end
