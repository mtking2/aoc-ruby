require "aoc_client"

module Solutions

	module Year2023

		class Day06

			YEAR = 2023
			DAY = 6

			def get_wins(time, rec)
				num_wins = 0
				(0..time - 1).each do |i|
					max_dist = i * (time - i)
					num_wins += 1 if max_dist > rec
				end
				num_wins
			end

			def part1(input)
				data = parse_input(input)
				races = data.values.first.zip(data.values.last)
				product = 1
				races.each do |time, rec|
					product *= get_wins(time, rec)
				end
				product
			end

			def part2(input)
				data = parse_input(input)
				time = data[:times].join.to_i
				rec = data[:distances].join.to_i
				get_wins(time, rec)
			end

			private

			def parse_input(input)
				times, distances = input.split("\n")
				times.sub!(/Time:\s+/, "")
				distances.sub!(/Distance:\s+/, "")
				{
					times: times.split(/\s+/).map(&:to_i),
					distances: distances.split(/\s+/).map(&:to_i)
				}
			end

		end

	end

end
