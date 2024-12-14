require "aoc_client"
require "matrix"

module Solutions

	module Year2024

		class Day10

			YEAR = 2024
			DAY = 10

			# 1  procedure BFS(G, root) is
			# 2      let Q be a queue
			# 3      label root as explored
			# 4      Q.enqueue(root)
			# 5      while Q is not empty do
			# 6          v := Q.dequeue()
			# 7          if v is the goal then
			# 8              return v
			# 9          for all edges from v to w in G.adjacentEdges(v) do
			# 10              if w is not labeled as explored then
			# 11                  label w as explored
			# 12                  w.parent := v
			# 13                  Q.enqueue(w)
			#
			DIRECTIONS = [
				Vector[0, -1],
				Vector[0, 1],
				Vector[-1, 0],
				Vector[1, 0]
			].freeze

			def get_score(map, trail_head)
				queue = [trail_head]
				visited = Set.new
				score = 0
				rating = 0

				until queue.empty?
					v = queue.pop
					if map[v] == 9
						score += 1 if visited.add?(v)
						rating += 1
					end

					DIRECTIONS.each do |direction|
						w = v + direction

						next if w.nil? || map[w].nil?

						height_diff = map[w] - map[v]
						if height_diff == 1
							queue.push(w)
						end
					end
				end

				{ score: score, rating: rating }
			end

			def part1(input)
				map = parse_input(input)
				map.sum do |key, value|
					(value == 0) ? get_score(map, key)[:score] : 0
				end
			end

			def part2(input)
				map = parse_input(input)
				map.sum do |key, value|
					(value == 0) ? get_score(map, key)[:rating] : 0
				end
			end

			private

			def parse_input(input)
				map_data = {}
				input.chomp.each_line.with_index do |line, y|
					line.chomp.chars.map.with_index do |char, x|
						cell = (char == ".") ? nil : char.to_i
						map_data[Vector[x, y]] = cell
					end
				end

				map_data
			end

		end

	end

end
