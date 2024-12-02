require "aoc_client"

module Solutions

	module Year2024

		class Day02

			YEAR = 2024
			DAY = 2

			def is_safe(report)
				within_diff = true
				doesnt_change_direction = true
				direction = report[1] <=> report[0]
				report.each_with_index do |level, i|
					if i > 0
						diff = (level - report[i - 1]).abs
						level_dir = level <=> report[i - 1]
						if diff < 1 || diff > 3
							within_diff = false
							break
						end
						if level_dir != direction
							doesnt_change_direction = false
							break
						end
					end
				end
				within_diff && doesnt_change_direction
			end

			def part1(input)
				reports = parse_input(input)

				safe_count = 0
				reports.each do |report|
					safe_count += 1 if is_safe(report)
				end
				safe_count
			end

			def part2(input)
				reports = parse_input(input)

				safe_count = 0
				reports.each_with_index do |report, report_idx|
					is_safe = is_safe(report)
					if is_safe
						safe_count += 1
						next
					end

					is_safe_with_removals = Array.new(report.length) do |i|
						removed_report = report.dup
						removed_report.delete_at(i)
						is_safe(removed_report)
					end.any?
					safe_count += 1 if is_safe_with_removals
				end
				safe_count
			end

			private

			def parse_input(input)
				input.split("\n").map { |line| line.split(" ").map(&:to_i) }
			end

		end

	end

end
