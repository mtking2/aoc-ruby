require "aoc_client"

module Solutions

	module Year2025

		class Day06

			YEAR = 2025
			DAY = 6

			def part1(input)
				rows, ops = parse_input_part1(input)
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
				end
				totals.sum
			end

			def part2(input)
				rows, ops = parse_input_part2(input)

				grand_total = 0
				op_counter = 0
				problem_vals = []

				rows.reverse_each.with_index do |row, i|
					value = row.join.strip
					if value.empty? || i == rows.length - 1
						problem_vals << value.to_i if i == rows.length - 1
						total = problem_vals.reduce(ops[op_counter % ops.length])
						grand_total += total

						# puts "problem_vals: #{problem_vals.inspect}, op: #{ops[op_counter % ops.length]}, total: #{total}, grand_total: #{grand_total}"
						op_counter += 1
						problem_vals = []
					else
						problem_vals << value.to_i
					end
				end
				# puts rows.reverse.map { |row| row.join.strip }.inspect
				# puts ops.inspect
				grand_total
			end

			private

			def parse_input_part1(input)
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

			def parse_input_part2(input)
				# Process the input and return the result
				lines = input.split("\n")
				ops = lines.pop.split(/\s+/).reject(&:empty?)

				lines.map! { |line| line.chars }
				[
					lines.transpose,
					ops.reverse
				]
			end

		end

	end

end
