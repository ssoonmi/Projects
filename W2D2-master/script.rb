p1 = Player.new(:green)
p2 = Player.new(:red)
b = Board.new(p1,p2)
b.move_piece!(p2.color, [6,5], [5,5])
b.move_piece!(p1.color, [1,4], [3,4])
b.move_piece!(p2.color, [6,6], [4,6])
b.move_piece!(p1.color, [0,3], [4,7])
b.move_piece!(p1.color, [6,7], [5,7])
b.move_piece!(p2.color, [7,7], [6,7])