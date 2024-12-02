require "aoc_client"

module Solutions

	module Year2024

		class Day01

			YEAR = 2024
			DAY = 1

			def part1(input)
				data = parse_input(input)
				left_list = data[:left_list]
				right_list = data[:right_list]

				left_list.zip(right_list).sum { |pair| (pair.last - pair.first).abs }
			end

			def part2(input)
				data = parse_input(input)
				left_list = data[:left_list]
				right_list = data[:right_list]

				similarity_score = 0
				right_list_counts = right_list.tally

				left_list.each do |n|
					similarity_score += n * (right_list_counts[n] || 0)
				end

				similarity_score
			end

			private

			def parse_input(input)
				left_list, right_list = [], []

				input.each_line do |line|
					left, right = line.split(/\s+/)
					left_list << left.to_i
					right_list << right.to_i
				end

				{
					left_list: left_list.sort,
					right_list: right_list.sort
				}
			end

		end

	end

end
