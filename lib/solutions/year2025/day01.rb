require "aoc_client"

module Solutions

	module Year2025

		class Day01

			YEAR = 2025
			DAY = 1

			def part1(input)
				current_position = 50
				num_zeros = 0
				input.split("\n").each do |line|
					direction, distance = line.partition(/\d+/).reject(&:empty?)
					direction = (direction == "R") ? 1 : -1
					distance = distance.to_i * direction

					new_position = (current_position + distance) % 100
					num_zeros += 1 if new_position == 0
					current_position = new_position
				end
				num_zeros
			end

			def part2(input)
				current_position = 50
				num_zeros = 0
				input.split("\n").each do |line|
					direction, distance = line.partition(/\d+/).reject(&:empty?)
					direction = (direction == "R") ? 1 : -1
					# distance = distance.to_i # * direction

					goes_into = distance.to_i / 100
					num_zeros += goes_into

					remainder = (distance.to_i % 100) * direction
					new_position = (current_position + remainder) % 100

					# puts "#{line}, Goes Into: #{goes_into}, Current Position: #{current_position}, New Position: #{new_position}"
					if new_position == 0 || (direction.positive? && new_position < current_position && current_position != 0) || (direction.negative? && new_position > current_position && current_position != 0)
						num_zeros += 1
						# puts "Reached zero"
					end
					current_position = new_position
				end
				num_zeros
			end

			private

			def parse_input(input)
				# Process the input and return the result
			end

		end

	end

end
