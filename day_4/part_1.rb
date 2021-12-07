drawings, *boards = File.open(ARGV[0]).readlines.map(&:strip).reject!(&:empty?)

drawings = drawings.split(",")
boards = boards.map { |row| row.split(/\s+/) }
boards_with_info = []

boards.each_slice(5) do |input|
  parsed_board = (0..4).flat_map do |row|
    (0..4).map do |col|
      {
        row: row,
        col: col,
        num: input[row][col],
        drawn: false
      }
    end
  end
  boards_with_info << parsed_board
end

drawings.first(5).each do |drawing|
  boards_with_info.each_with_index do |board, board_idx|
    p "------ BOARD ##{board_idx + 1}"
    box = nil
    box_idx = nil

    board.each_with_index do |b, i|
      next unless b[:num] == drawing

      box = b
      box_idx = i
      break
    end

    next unless box

    boards_with_info[board_idx][box_idx] = box.merge(drawn: true)
    boards_with_info[board_idx].each_slice(5) do |row|
      r = row.map do |b|
        n = b[:num].rjust(2)
        b[:drawn] ? "#{n}*".ljust(4) : n.ljust(4)
      end.join(" ")
      p r
    end
  end
end
