require "aoc_client"

module Solutions

	module Year2023

		class Day08

			YEAR = 2023
			DAY = 8

			# fine for small networks, but stack overflows on large networks
			def traverse_network_recursively(network, node, inst_index)
				puts "node: #{node}, inst_index: #{inst_index}"
				return inst_index if node == "ZZZ"

				instruction = networkcurrent_context[inst_index % network["INS"].length]
				next_index = (instruction == "L") ? 0 : 1
				next_node = network[node][next_index]
				traverse_network_recursively(network, next_node, inst_index + 1)
			end

			def traverse_network_part1(network, starting_node)
				step = 0
				node = starting_node
				while node != "ZZZ"
					# puts "node: #{node}, step: #{step}"
					instruction = network["INS"][step % network["INS"].length]
					next_index = (instruction == "L") ? 0 : 1
					node = network[node][next_index]
					step += 1
				end
				step
			end

			# brute force - takes way too long
			def traverse_network_part2_attempt1(network, starting_nodes)
				step = 0
				nodes = starting_nodes
				until nodes.all? { |n| n.end_with?("Z") }

					instruction = network["INS"][step % network["INS"].length]
					next_index = (instruction == "L") ? 0 : 1
					nodes = nodes.map { |n| network[n][next_index] }
					step += 1
					puts "nodes: #{nodes}, step: #{step}"
				end
				step
			end

			def traverse_network_part2_attempt2(network, starting_nodes)
				steps_to_first_z_node = Array.new(starting_nodes.length, 0)

				step = 0
				nodes = starting_nodes
				until nodes.all? { |n| n.end_with?("Z") }
					nodes.each_with_index do |n, i|
						if !n.end_with?("Z")
							instruction = network["INS"][step % network["INS"].length]
							next_index = (instruction == "L") ? 0 : 1
							steps_to_first_z_node[i] += 1
							nodes[i] = network[n][next_index]
						end
					end
					step += 1
				end

				# assuming all ghosts will loop after reaching their first Z node
				# we can just find the LCM of the # of steps to reach the first Z node of each ghost
				steps_to_first_z_node.reduce(1) { |acc, num| acc.lcm(num) }
			end

			def part1(input)
				network = parse_input(input)
				traverse_network_part1(network, "AAA")
			end

			def part2(input)
				network = parse_input(input)
				starting_nodes = network.keys.select { |k| k.end_with?("A") }

				puts "#{starting_nodes.length} starting_nodes: #{starting_nodes}"

				# traverse_network_part2_attempt1(network, starting_nodes)
				traverse_network_part2_attempt2(network, starting_nodes)
			end

			private

			def parse_input(input)
				left_right_instructions, network_str = input.split("\n\n")
				network = {}

				network_str.split("\n").each do |line|
					node, connections = line.split(" = ")
					left, right = connections.tr!("()", "").split(", ")
					network[node] = [left, right]
				end

				network["INS"] = left_right_instructions
				network
			end

		end

	end

end
