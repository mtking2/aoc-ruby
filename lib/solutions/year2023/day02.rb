require "aoc_client"

module Solutions

	module Year2023

		class Day02

			YEAR = 2023
			DAY = 2

			MAX_RED = 12
			MAX_GREEN = 13
			MAX_BLUE = 14

			def part1(input)
				data = parse_input(input)
				total = 0
				data.each do |game_num, colors_counts|
					is_possible_game = colors_counts["red"] <= MAX_RED &&
						colors_counts["green"] <= MAX_GREEN &&
						colors_counts["blue"] <= MAX_BLUE

					total += game_num.to_i if is_possible_game
				end
				total
			end

			def part2(input)
				data = parse_input(input)
				total = 0
				data.each do |game_num, colors_counts|
					power = colors_counts.values.reject(&:zero?).reduce(:*)
					total += power
				end
				total
			end

			private

			def parse_input(input)
				data = {}
				input.each_line do |line|
					game, sets = line.split(":")
					_, game_num = game.split
					sets.split(";").each do |set|
						set.split(",").each do |color_group|
							num_color, color = color_group.split
							data[game_num] ||= {}
							data[game_num][color] ||= 0
							data[game_num][color] = num_color.to_i if data[game_num][color] < num_color.to_i
						end
					end
				end
				data
			end

		end

	end

end
