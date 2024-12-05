require "aoc_client"

module Solutions

	module Year2024

		class Day05

			YEAR = 2024
			DAY = 5

			def part1(input)
				data = parse_input(input)

				total = 0

				data[:updates].each do |update|
					is_ordered = true
					data[:rules].each do |rule|
						next if !update.include?(rule[0]) || !update.include?(rule[1])

						if update.index(rule[0]) > update.index(rule[1])
							is_ordered = false
							break
						end
					end
					total += update[update.length / 2] if is_ordered
				end

				total
			end

			def part2(input)
				data = parse_input(input)

				total = 0

				data[:updates].each do |update|
					applicable_rules = data[:rules].select do |rule|
						update.include?(rule[0]) && update.include?(rule[1])
					end

					is_ordered = applicable_rules.all? do |rule|
						update.index(rule[0]) < update.index(rule[1])
					end

					next if is_ordered

					# keep swapping until all rules are satisfied
					until is_ordered
						applicable_rules.each do |rule|
							rule1_idx = update.index(rule[0])
							rule2_idx = update.index(rule[1])

							if rule1_idx > rule2_idx
								update[rule1_idx], update[rule2_idx] = update[rule2_idx], update[rule1_idx]
							end
						end

						is_ordered = applicable_rules.all? do |rule|
							update.index(rule[0]) < update.index(rule[1])
						end
					end

					total += update[update.length / 2]
				end

				total
			end

			private

			def parse_input(input)
				rules_str, updates_str = input.split("\n\n")

				rules = rules_str.split("\n").map do |rule_str|
					rule_str.split("|").map(&:to_i)
				end

				updates = updates_str.split("\n").map do |update_str|
					update_str.split(",").map(&:to_i)
				end

				{ rules: rules, updates: updates }
			end

		end

	end

end
