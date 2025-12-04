require "aoc_client"

module Solutions

	module Year2024

		class Day04

			YEAR = 2024
			DAY = 4

			def part1(input)
				word = "XMAS"
				word_search = parse_input(input)
				num_rows = word_search.length
				count = 0
				should_print = false

				word_search.each_with_index do |row, i|
					num_cols = row.length
					row.each_with_index do |char, j|
						if char == "X"

							space_north = i >= word.length - 1
							space_south = i <= (num_rows - 1) - (word.length - 1)
							space_east = j <= (num_cols - 1) - (word.length - 1)
							space_west = j >= word.length - 1

							space_north_east = space_north && space_east
							space_north_west = space_north && space_west
							space_south_east = space_south && space_east
							space_south_west = space_south && space_west

							if space_north
								# Check north
								word.chars.each_with_index do |letter, k|
									if word_search[i - k][j] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS north at (#{i},#{j})" if should_print
									end
								end
							end

							if space_south
								# Check south
								word.chars.each_with_index do |letter, k|
									if word_search[i + k][j] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS south at (#{i},#{j})" if should_print
									end
								end
							end

							if space_east
								# Check east
								word.chars.each_with_index do |letter, k|
									if word_search[i][j + k] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS east at (#{i},#{j})" if should_print
									end
								end
							end

							if space_west
								# Check west
								word.chars.each_with_index do |letter, k|
									if word_search[i][j - k] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS west at (#{i},#{j})" if should_print
									end
								end
							end

							if space_north_east
								# Check north east
								word.chars.each_with_index do |letter, k|
									if word_search[i - k][j + k] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS NE at (#{i},#{j})" if should_print
									end
								end
							end

							if space_north_west
								# Check north west
								word.chars.each_with_index do |letter, k|
									if word_search[i - k][j - k] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS NW at (#{i},#{j})" if should_print
									end
								end
							end

							if space_south_east
								# Check south east
								word.chars.each_with_index do |letter, k|
									if word_search[i + k][j + k] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS SE at (#{i},#{j})" if should_print
									end
								end
							end

							if space_south_west
								# Check south west
								word.chars.each_with_index do |letter, k|
									if word_search[i + k][j - k] != letter
										break
									end
									if k == word.length - 1
										count += 1
										puts "XMAS SW at (#{i},#{j})" if should_print
									end
								end
							end

						end
					end
				end

				count
			end

			def part2(input)
				word_search = parse_input(input)
				num_rows = word_search.length
				count = 0

				word_search.each_with_index do |row, i|
					num_cols = row.length
					row.each_with_index do |char, j|
						if char == "A"

							space_north_south = i.between?(1, num_rows - 2)
							space_east_west = j.between?(1, num_cols - 2)

							if space_north_south && space_east_west
								nw = word_search[i - 1][j - 1]
								ne = word_search[i - 1][j + 1]
								sw = word_search[i + 1][j - 1]
								se = word_search[i + 1][j + 1]

								# check NW & SE
								nw_se = nw == "M" && se == "S" || nw == "S" && se == "M"

								# check NE & SW
								ne_sw = ne == "M" && sw == "S" || ne == "S" && sw == "M"

								count += 1 if nw_se && ne_sw
							end

						end
					end
				end

				count
			end

			private

			def parse_input(input)
				input.split("\n").map { |line| line.chars }
			end

		end

	end

end
