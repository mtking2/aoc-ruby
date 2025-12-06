require "aoc_client"

module Solutions

	module Year2025

		class Day03

			YEAR = 2025
			DAY = 3

			def part1(input)
				banks = parse_input(input)
				banks.sum { |bank|
					bank.combination(2).map { |x| x.join.to_i }.max
				}
			end

			def part2(input)
				banks = parse_input(input)
				# 9 8 7 6 5 4 3 2 1
				# loop through 9..1
				# find first one with index <= 12 from the end
				# add to accumlator and repeat with 12 - n

				banks.sum do |bank|
					accumulator = []
					cursor = 0
					# puts "bank #{bank.join}"

					while accumulator.size < 12
						(1..9).reverse_each do |i|
							value_found = false
							(cursor..bank.size - 1).each do |j|
								check_idx = bank.size - (12 - accumulator.size)
								value = bank[j]
								# puts "i:#{i} j:#{j} value:#{value} check_idx:#{check_idx} cursor:#{cursor}"
								if value.to_i == i && j <= check_idx
									accumulator << value
									cursor = j + 1
									# puts accumulator.join
									value_found = true
									break
								end
								# sleep(0.5)
							end
							break if value_found
						end
					end
					# puts accumulator.join
					accumulator.join.to_i
				end
			end

			private

			def parse_input(input)
				# Process the input and return the result
				input.split("\n").map { |line| line.chars }
			end

		end

	end

end
