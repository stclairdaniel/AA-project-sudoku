require 'colorize'

class Tile

  attr_accessor :value
  attr_reader :given

  def initialize(value, given = false)
    @value = value
    @given = given
  end

  def to_s
    return "#{value}".colorize(:light_blue) if @given
    "#{value}"
  end

end
