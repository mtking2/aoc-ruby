require "aoc_client"

module Solutions

	module Year2024

		class Day11

			YEAR = 2024
			DAY = 11

			def part1(input, iterations)
				stones = parse_input(input)
				# puts stones.inspect

				iterations.times do |_|
					stone_idx = 0

					for _ in 0..stones.length - 1 # rubocop:disable Style/For
						stone = stones[stone_idx]
						if stone == 0
							stones[stone_idx] = 1
							stone_idx += 1
						elsif stone.to_s.length % 2 == 0
							mid = stone.to_s.length / 2
							left, right = [stone.to_s[0..mid - 1], stone.to_s[mid..]]
							stones[stone_idx] = left.to_i
							stones.insert(stone_idx + 1, right.to_i)
							stone_idx += 2
						else
							stones[stone_idx] *= 2024
							stone_idx += 1
						end
					end

					# puts stones.inspect
				end

				stones.length
			end

			def part2(input)
				# Your code here
			end

			private

			def parse_input(input)
				input.split(" ").map(&:to_i)
			end

		end

	end

end
