require "aoc_client"
require "json/add/ostruct"

module Solutions

	module Year2024

		class Day06

			YEAR = 2024
			DAY = 6

			def within_bounds?(map, pos)
				pos.y >= 0 && pos.y < map.length && pos.x >= 0 && pos.x < map[pos.y].length
			end

			def move(pos, dir)
				OpenStruct.new(x: pos.x + dir.dx, y: pos.y + dir.dy)
			end

			def dir_map
				{
					"^" => OpenStruct.new(dx: 0, dy: -1),
					"v" => OpenStruct.new(dx: 0, dy: 1),
					"<" => OpenStruct.new(dx: -1, dy: 0),
					">" => OpenStruct.new(dx: 1, dy: 0)
				}
			end

			def turn(str)
				case str
				when "^" then ">"
				when ">" then "v"
				when "v" then "<"
				when "<" then "^"
				end
			end

			def get_starting_pos_and_dir(map)
				start_pos = OpenStruct.new(x: 0, y: 0)
				map.each_with_index do |row, y|
					row.each_with_index do |cell, x|
						if dir_map.key?(cell)
							start_pos = OpenStruct.new(x: x, y: y)
							break
						end
					end
				end
				dir_str = map[start_pos.y][start_pos.x]

				[start_pos, dir_str]
			end

			def get_visited_positions2(map, start_pos: OpenStruct.new(x: 0, y: 0), dir_str: "^", obstacle: nil)
				pos = start_pos
				dir = dir_map[dir_str]

				visited_positions = ["#{pos.x},#{pos.y}"]

				while within_bounds?(map, pos) && visited_positions.tally.values.uniq.all? { |v| v < 5 }
					next_pos = move(pos, dir)
					if !within_bounds?(map, next_pos)
						break
					end

					next_cell = map[next_pos.y][next_pos.x]
					at_obstacle = false
					if obstacle
						at_obstacle = obstacle[0] == next_pos.x && obstacle[1] == next_pos.y
					end

					if next_cell == "#" || at_obstacle
						dir_str = turn(dir_str)
						new_dir = dir_map[dir_str]
						dir = new_dir
					else
						pos = next_pos
						visited_positions << "#{pos.x},#{pos.y}"
					end
				end
				visited_positions
			end

			def part1(input)
				map = parse_input(input)

				start_pos, dir_str = get_starting_pos_and_dir(map)
				map[start_pos.y][start_pos.x] = "."

				visited_positions = get_visited_positions2(map, start_pos: start_pos, dir_str: dir_str)
				visited_positions.uniq.count
			end

			def part2(input)
				map = parse_input(input)
				start_pos, dir_str = get_starting_pos_and_dir(map)
				map[start_pos.y][start_pos.x] = "."

				count = 0

				og_visited_positions = get_visited_positions2(map, start_pos: start_pos, dir_str: dir_str).uniq

				# brute force
				og_visited_positions.each_with_index do |pos, i|
					x, y = pos.split(",").map(&:to_i)
					if start_pos.x == x && start_pos.y == y
						# puts "Skipping (#{y},#{x})"
						next
					end

					# percentage = ((i + 1).to_f / og_visited_positions.length * 100).round
					# puts "Checking (#{y},#{x}) #{i + 1}/#{og_visited_positions.length} #{percentage}%"

					visited_positions = get_visited_positions2(map, start_pos: start_pos, dir_str: dir_str, obstacle: [x, y])
					if visited_positions.tally.values.uniq.any? { |v| v >= 5 }
						# puts "LOOP AT (#{y},#{x})"
						count += 1
					end
				end
				count
			end

			private

			def parse_input(input)
				input.split("\n").map(&:chars)
			end

		end

	end

end
