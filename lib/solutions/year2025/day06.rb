require "aoc_client"

module Solutions

	module Year2025

		class Day06

			YEAR = 2025
			DAY = 6

			def part1(input)
				rows, ops = parse_input(input)
				# puts rows.inspect
				# puts ops.inspect
				# puts
				totals = rows.shift
				rows.each_with_index do |row, i|
					# puts row.inspect
					row.each_with_index do |value, j|
						# puts "#{i}, #{j}: #{value} #{ops[j]}"
						totals[j] = totals[j].send(ops[j], value)
						# puts "totals: #{totals.inspect}"
					end
					puts
				end
				totals.sum
			end

			def part2(input)
				# Your code here
			end

			private

			def parse_input(input)
				# Process the input and return the result
				lines = input.split("\n")
				ops = lines.pop.split(/\s+/).reject(&:empty?)

				lines.map! { |line| line.split(/\s+/).reject(&:empty?) }
				lines.map! { |line| line.map(&:to_i) }
				[
					lines,
					ops
				]
			end

		end

	end

end
