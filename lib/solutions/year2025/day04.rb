require "aoc_client"

module Solutions

	module Year2025

		class Day04

			YEAR = 2025
			DAY = 4

			# nw n ne
			#  w x e
			# sw s se
			def remove_paper(grid)
				grid_copy = grid.map(&:dup)
				count = 0
				grid.each_with_index do |row, row_idx|
					row.each_with_index do |cel, col_idx|
						nw = (row_idx > 0 && col_idx > 0 && grid[row_idx - 1][col_idx - 1] == "@") ? 1 : 0
						n = (row_idx > 0 && grid[row_idx - 1][col_idx] == "@") ? 1 : 0
						ne = (row_idx > 0 && col_idx < grid[row_idx].length - 1 && grid[row_idx - 1][col_idx + 1] == "@") ? 1 : 0
						w = (col_idx > 0 && grid[row_idx][col_idx - 1] == "@") ? 1 : 0
						e = (col_idx < grid[row_idx].length - 1 && grid[row_idx][col_idx + 1] == "@") ? 1 : 0
						sw = (row_idx < grid.length - 1 && col_idx > 0 && grid[row_idx + 1][col_idx - 1] == "@") ? 1 : 0
						s = (row_idx < grid.length - 1 && grid[row_idx + 1][col_idx] == "@") ? 1 : 0
						se = (row_idx < grid.length - 1 && col_idx < grid[row_idx].length - 1 && grid[row_idx + 1][col_idx + 1] == "@") ? 1 : 0
						total = nw + n + ne + w + e + sw + s + se
						if cel == "@" && total < 4
							# puts "(#{row_idx},#{col_idx}) total #{total}"
							grid_copy[row_idx][col_idx] = "."
							count += 1
						end
					end
				end
				# puts
				# grid_copy.each { |row| puts row.join }
				# puts
				{
					count: count,
					grid: grid_copy
				}
			end

			def part1(input)
				grid = parse_input(input)
				result = remove_paper(grid)
				result[:count]
			end

			def part2(input)
				grid = parse_input(input)
				total = 0

				loop do
					result = remove_paper(grid)
					total += result[:count]
					# puts "removed #{result[:count]} rolls of paper"
					break if result[:count] == 0
					grid = result[:grid]
				end
				total
			end

			private

			def parse_input(input)
				input.split("\n").map(&:chars)
			end

		end

	end

end
