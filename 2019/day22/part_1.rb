INSTRUCTION_TYPES = [
    1, # deal into new stack
    2, # cut
    3, # deal with increment
]

Instruction = Struct.new(:type, :value)

class Dealer
    attr_reader :instructions, :cards
    def initialize(cards, instructions)
        @cards = cards
        @instructions = instructions

        parse_instructions
    end

    def deal
        instructions.each do |inst|
            case inst.type
            when 1
                @cards.reverse!
            when 2
                if inst.value > 0
                  @cards = cards.push(cards.shift(inst.value)).flatten
                else
                  @cards = cards.unshift(cards.pop(inst.value.abs)).flatten
                end
            when 3
                temp_deck = Array.new(cards.size)
                increment = 0
                cards.each_with_index do |card, index|
                    position = increment % cards.length
                    temp_deck[position] = card
                    increment += inst.value
                end
                @cards = temp_deck
            end
        end
    end

    private def parse_instructions
        @instructions = @instructions.split("\n").map do |inst|
          case inst
          when /deal into new stack/
            Instruction.new(1)
          when /cut/
            Instruction.new(2, inst.split.last.to_i)
          when /increment/
            Instruction.new(3, inst.split.last.to_i)
          else
            inst
          end
        end
    end
end

example_instructions = File.read("example_input")
example_cards = (0..9).to_a

d = Dealer.new(example_cards, example_instructions)
d.deal

instructions = File.read("input")
cards = (0..10006).to_a


## Part 1
d = Dealer.new(cards, instructions)
d.deal
p d.cards.index(2019)

## Part 2
cards = (0..119315717514046).to_a
d = Dealer.new(cards, instructions)
101741582076661.times do |i|
    p i
    d.deal
end
p d.cards[2020]
