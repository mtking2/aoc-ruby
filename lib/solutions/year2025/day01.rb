require "aoc_client"

module Solutions

	module Year2025

		class Day01

			YEAR = 2025
			DAY = 1

			def part1(input)
				# Your code here
				current_position = 50
				num_zeros = 0
				input.split("\n").each do |line|
					direction, distance = line.partition(/\d+/).reject(&:empty?)
					direction = (direction == "R") ? 1 : -1
					distance = distance.to_i * direction

					new_position = (current_position += distance) % 100
					num_zeros += 1 if new_position == 0
				end
				num_zeros
			end

			def part2(input)
				# Your code here
			end

			private

			def parse_input(input)
				# Process the input and return the result
			end

		end

	end

end
