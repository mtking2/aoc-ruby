require "aoc_client"

module Solutions

	module Year2025

		class Day05

			YEAR = 2025
			DAY = 5

			def part1(input)
				ranges, ids = parse_input(input)
				count = 0
				ids.each do |id|
					in_range = ranges.any? do |range|
						id.between?(range[0], range[1])
					end
					count += 1 if in_range
				end
				count
			end

			def part2(input)
				ranges, _ids = parse_input(input)

				# check for overlapping ranges and combine them
				ranges.sort!
				merged_ranges = [ranges.first]
				ranges.each do |range|
					last_range = merged_ranges.last
					if range[0] <= last_range[1] + 1
						last_range[1] = [last_range[1], range[1]].max
					else
						merged_ranges << range
					end
				end

				count = 0
				merged_ranges.each do |range|
					count += range[1] - range[0] + 1
				end
				count
			end

			private

			def parse_input(input)
				# Process the input and return the result
				ranges, ids = input.split("\n\n")
				[
					ranges.split("\n").map { |range| range.split("-").map(&:to_i) },
					ids.split("\n").map(&:to_i)
				]
			end

		end

	end

end
