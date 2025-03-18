require "aoc_client"

module Solutions

	module Year2024

		class Day11

			YEAR = 2024
			DAY = 11

			def blink_iterative(stones, num_blinks)
				num_blinks.times do |i|
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

					puts "iteration: #{i}, stones: #{stones.length}"
				end

				stones.length
			end

			def blink(stones, num_blinks)
				stone_count_map = stones.tally

				num_blinks.times do
					next_map = Hash.new { 0 }

					stone_count_map.each do |stone, count|
						if stone == 0
							next_map[1] += count
						elsif stone.digits.length.even?
							mid = stone.to_s.length / 2
							left, right = [stone.to_s[0..mid - 1].to_i, stone.to_s[mid..].to_i]
							next_map[left] += count
							next_map[right] += count
						else
							next_map[stone * 2024] += count
						end
					end

					stone_count_map = next_map
				end

				stone_count_map.values.sum
			end

			def part1(input, num_blinks)
				stones = parse_input(input)
				blink(stones, num_blinks)
			end

			def part2(input, num_blinks)
				stones = parse_input(input)
				blink(stones, num_blinks)
			end

			private

			def parse_input(input)
				input.split(" ").map(&:to_i)
			end

		end

	end

end
