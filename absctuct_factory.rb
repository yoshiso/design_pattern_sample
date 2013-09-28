
# サックス
class Saxophone
  def initialize(name)
    @name=name
  end

  def play
    puts "#{@name} は音を奏でています"
  end
end

# トランペット
class Tranpet
  def initialize(name)
    @name = name
  end

  def play
    puts "#{@name} はを奏でています"
  end
end

# 楽器工場

class InstrumentsFactory
  def initialize(number_instruments)
    @instruments = []
    number_instruments.times do |i|
      @instruments << new_instrument(i)
    end
  end

  def ship_out
    @tmp = @instruments.dup
    @instruments = []
    @tmp
  end
end

class TranpetFactory < InstrumentsFactory
  def new_instrument(index)
    Tranpet.new("トランペット #{index}")
  end
end

class SaxsophoneFactory < InstrumentsFactory
  def new_instrument(index)
    Saxophone.new("サクソフォン #{index}")
  end
end

if __FILE__==$PROGRAM_NAME
  factory = SaxsophoneFactory.new(3)
  saxophones = factory.ship_out
  saxophones.each {|sax| sax.play}
  factory = TranpetFactory.new(4)
  tranpets = factory.ship_out
  tranpets.each{ |tran| tran.play}
end