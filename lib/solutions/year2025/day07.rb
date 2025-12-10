require "aoc_client"

module Solutions

	module Year2025

		class Day07

			YEAR = 2025
			DAY = 7

			def part1(input)
				grid = parse_input(input)
				split_counter = 0

				grid.each_with_index do |row, row_idx|
					next if row_idx == grid.length - 1

					row.each_with_index do |cell, col_idx|
						if cell == "S" && grid[row_idx + 1][col_idx] != "^"
							grid[row_idx + 1][col_idx] = "|"
						end

						if cell == "|"
							if grid[row_idx + 1][col_idx] == "."
								grid[row_idx + 1][col_idx] = "|"
							elsif grid[row_idx + 1][col_idx] == "^"
								grid[row_idx + 1][col_idx + 1] = "|"
								grid[row_idx + 1][col_idx - 1] = "|"
								split_counter += 1
							end
						end
					end
				end

				# puts grid.map(&:join).join("\n")

				split_counter
			end

			def propagate(grid, row, col, cache)
				if row == grid.length - 1
					return 1
				end

				cache_key = "#{row},#{col}"
				if cache.key?(cache_key)
					return cache[cache_key]
				end

				next_cell = grid[row + 1][col]
				result = 0

				if next_cell == "."
					result = propagate(grid, row + 1, col, cache)
				elsif next_cell == "^"
					result = propagate(grid, row + 1, col + 1, cache) + propagate(grid, row + 1, col - 1, cache)
				end

				cache[cache_key] = result
				result
			end

			# https://www.youtube.com/watch?v=JXUOMsFBDXQ
			def part2(input)
				grid = parse_input(input)

				start_row = 0
				start_col = grid.first.index("S")
				cache = {}
				propagate(grid, start_row, start_col, cache)
			end

			private

			def parse_input(input)
				# Process the input and return the result
				input.split("\n").map { |line| line.chars }
			end

		end

	end

end
