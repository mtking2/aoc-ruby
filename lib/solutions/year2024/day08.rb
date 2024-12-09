require "aoc_client"

module Solutions

	module Year2024

		class Day08

			YEAR = 2024
			DAY = 8

			def get_antinodes_part1(antennas)
				antinodes = []
				antennas.each_with_index do |antenna, i|
					antennas.each_with_index do |other_antenna, j|
						next if i == j
						# puts "antenna: #{antenna}, other_antenna: #{other_antenna}"

						if antenna[:freq] == other_antenna[:freq]
							dy = antenna[:i] - other_antenna[:i]
							dx = antenna[:j] - other_antenna[:j]
							antinodes << [antenna[:i] + dy, antenna[:j] + dx]
							antinodes << [other_antenna[:i] - dy, other_antenna[:j] - dx]
						end
					end
				end
				antinodes
			end

			def get_antinodes_part2(antennas, size)
				antinodes = []
				antennas.each_with_index do |antenna, i|
					antennas.each_with_index do |other_antenna, j|
						next if i == j

						if antenna[:freq] == other_antenna[:freq]
							a1 = [antenna[:i], antenna[:j]]
							a2 = [other_antenna[:i], other_antenna[:j]]

							# include antennas themselves as antinodes
							antinodes << a1.dup
							antinodes << a2.dup

							dy = antenna[:i] - other_antenna[:i]
							dx = antenna[:j] - other_antenna[:j]

							while a1[0] >= 0 && a1[0] < size && a1[1] >= 0 && a1[1] < size
								antinodes << a1.dup
								a1 = [a1[0] + dy, a1[1] + dx]
							end
							while a2[0] >= 0 && a2[0] < size && a2[1] >= 0 && a2[1] < size
								antinodes << a2.dup
								a2 = [a2[0] - dy, a2[1] - dx]
							end

						end
					end
				end
				antinodes
			end

			def part1(input)
				map = parse_input(input)

				antennas = []
				map.each_with_index do |row, i|
					row.each_with_index do |cell, j|
						if /[A-Za-z\d]/.match?(cell)
							antennas << {
								freq: map[i][j],
								i: i,
								j: j
							}
						end
					end
				end
				antinodes = get_antinodes_part1(antennas).uniq

				antinodes.uniq.count do |antinode|
					antinode[0] >= 0 && antinode[0] < map.length && antinode[1] >= 0 && antinode[1] < map[0].length
				end
			end

			def part2(input)
				map = parse_input(input)

				antennas = []
				map.each_with_index do |row, i|
					row.each_with_index do |cell, j|
						if /[A-Za-z\d]/.match?(cell)
							antennas << {
								freq: map[i][j],
								i: i,
								j: j
							}
						end
					end
				end
				antinodes = get_antinodes_part2(antennas, map.size).uniq

				antinodes.uniq.count do |antinode|
					antinode[0] >= 0 && antinode[0] < map.length && antinode[1] >= 0 && antinode[1] < map[0].length
				end
			end

			private

			def parse_input(input)
				input.split("\n").map(&:chars)
			end

		end

	end

end
