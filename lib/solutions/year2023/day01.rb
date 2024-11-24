require "aoc_client"

module Solutions

	module Year2023

		class Day01

			YEAR = 2023
			DAY = 1

			def part1(input)
				total = 0
				parse_input(input).each do |line|
					digits = line.chars.select { |c| c =~ /\d/ } # select only digits from array of chars
					# puts "digits: #{digits}"
					calibration_value = "#{digits.first}#{digits.last}".to_i
					total += calibration_value
				end
				total
			end

			DIGIT_MAP = {
				# overlapping digits
				"twone" => 21,
				"oneight" => 18,
				"threeight" => 38,
				"fiveight" => 58,
				"sevenine" => 79,
				"eightwo" => 82,
				"eighthree" => 83,
				"nineight" => 98,
				# normal digits
				"one" => 1,
				"two" => 2,
				"three" => 3,
				"four" => 4,
				"five" => 5,
				"six" => 6,
				"seven" => 7,
				"eight" => 8,
				"nine" => 9
			}

			def part2(input)
				total = 0
				parse_input(input).each do |line|
					parsed_line = line.gsub(/(#{DIGIT_MAP.keys.join("|")})/) { |m| DIGIT_MAP[m] }
					digits = parsed_line.chars.select { |c| c =~ /\d/ }
					# puts "line: #{line}\ndigits: #{digits}"
					calibration_value = "#{digits.first}#{digits.last}".to_i
					total += calibration_value
				end
				total
			end

			private

			def parse_input(input)
				input.split
			end

		end

	end

end
