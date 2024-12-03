require "aoc_client"

module Solutions

	module Year2024

		class Day03

			YEAR = 2024
			DAY = 3

			def part1(input)
				numbers = []

				input.scan(/mul\((\d+,\d+)\)/) do |pair|
					numbers << pair.first.split(",").map(&:to_i)
				end
				numbers.sum { |a, b| a * b }
			end

			def part2(input)
				numbers = []

				toggle = true
				input.scan(/(don't\(\)|do\(\)|mul\(\d+,\d+\))/) do |match|
					token = match.first
					next if token.nil?

					if token == "do()"
						toggle = true
					elsif token == "don't()"
						toggle = false
					elsif toggle
						numbers << token.tr("mul()", "").split(",").map(&:to_i)
					end
				end
				numbers.sum { |a, b| a * b }
			end

			private

			def parse_part1_input(input)
			end

			def parse_part2_input(input)
			end

		end

	end

end
