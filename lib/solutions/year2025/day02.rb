require "aoc_client"

module Solutions

	module Year2025

		class Day02

			YEAR = 2025
			DAY = 2

			def part1(input)
				ranges = parse_input(input)
				invalid_ids = []
				ranges.each do |pair|
					min, max = pair
					(min..max).each do |num|
						next if num.to_s.length % 2 != 0
						first_half = num.to_s[0..num.to_s.length / 2 - 1]
						second_half = num.to_s[num.to_s.length / 2..]
						invalid_ids << num if first_half == second_half
					end
				end
				invalid_ids.sum
			end

			def part2(input)
				ranges = parse_input(input)
				invalid_ids = []
				ranges.each do |pair|
					min, max = pair
					(min..max).each do |num|
						num.to_s.length.times do |i|
							next if i + 1 == num.to_s.length
							next if num.to_s.length % (i + 1) != 0
							segments = num.to_s.chars.each_slice(i + 1).map(&:join)
							if segments.all?(segments.first)
								# puts "#{i + 1} #{segments.inspect}"
								invalid_ids << num
								break
							end
						end
					end
				end
				invalid_ids.sum
			end

			private

			def parse_input(input)
				# Process the input and return the result
				input.split(",").map { |x| x.split("-").map(&:to_i) }
			end

		end

	end

end
