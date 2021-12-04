#input = File.readlines("./input_test")
input = File.read("./input")
win_boards = []

numbers = input.split("\n\n").first

boards = input.split("\n\n")
boards = boards[1..-1]

numbers = numbers.split(",")
numbers.size.times do |round|
  boards.each_with_index do |board, board_index|
    rows = board.split("\n")
    rows.each_with_index do |row, i|
      if (row.split(" ") - numbers[0..round]).empty?
        win_boards << board_index unless win_boards.include?(board_index)
        if win_boards.size == 1
          win = boards[win_boards.first].split("\n")
          win = win.reject.with_index{|v, ind| ind == i}
          int_numbers = win.join(" ").split(" ")
          int_numbers = int_numbers.reject{|num| numbers[0..round].include?(num)}
          p int_numbers.map(&:to_i).inject(0, :+) * numbers[round].to_i
        end
      end

    end
    cols = []
    5.times do |i|
      cols << board.split("\n").map{|row| board[row].split(" ")[i]}
    end

    cols.each do |col|
      if (col - numbers[0..round]).empty?
        win_boards << board_index unless win_boards.include?(board_index)
      end
    end

    if win_boards.size == boards.size
      board = boards[win_boards.last]
      board = board.split("\n")
      int_numbers = board.join(" ").split(" ")
      int_numbers = int_numbers.reject{|num| numbers[0..round].include?(num)}
      p int_numbers.map(&:to_i).inject(0, :+) * numbers[round].to_i
      return
    end
  end
end

