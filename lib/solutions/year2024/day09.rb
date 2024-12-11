require "aoc_client"

module Solutions

	module Year2024

		class Day09

			YEAR = 2024
			DAY = 9

			def checksum(blocks)
				checksum = 0
				blocks.each_with_index do |block, index|
					checksum += block * index unless block.nil?
				end
				checksum
			end

			def compress(data)
				blocks = data[:blocks]
				left = 0
				right = blocks.length - 1

				while left < right
					if !blocks[left].nil?
						left += 1
					elsif blocks[right].nil?
						right -= 1
					else
						blocks[left] = blocks[right]
						blocks[right] = nil
					end
				end

				blocks
			end

			def defrag(data)
				blocks = data[:blocks]
				file_sizes = data[:file_sizes]
				file_index = data[:file_index]

				start_search = Hash.new(0)
				file_sizes.reverse_each do |file_id, size|
					(start_search[size]...file_index[file_id]).each do |window_start|
						next unless blocks[window_start...window_start + size].all?(&:nil?)

						start_search[size] = window_start + size
						(0...size).each do |offset|
							blocks[window_start + offset] = file_id
							blocks[file_index[file_id] + offset] = nil
						end
						break
					end
				end
				blocks
			end

			def part1(input)
				data = parse_input(input)
				checksum(compress(data))
			end

			def part2(input)
				data = parse_input(input)
				checksum(defrag(data))
			end

			def parse_input(input)
				blocks = []
				file_sizes = {}
				file_index = {}

				file_id = 0
				current_index = 0
				file = true
				input.chomp.chars.each do |char|
					size = char.to_i
					blocks += file ? [file_id] * size : [nil] * size

					if file
						file_sizes[file_id] = size
						file_index[file_id] = current_index
						file_id += 1
					end

					current_index += size
					file = !file
				end
				{
					blocks: blocks,
					file_sizes: file_sizes,
					file_index: file_index
				}
			end

		end

	end

end
