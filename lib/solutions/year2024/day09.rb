require "aoc_client"

module Solutions

	module Year2024

		class Day09

			YEAR = 2024
			DAY = 9

			def defrag(block_fmt_data, mut: false)
				puts "defragging..."
				array = mut ? block_fmt_data : block_fmt_data.dup

				0.upto(array.size - 1) do |i|
					if array[i] == "."
						(array.size - 1).downto(i + 1) do |j|
							next if array[j] == "."

							array[i], array[j] = array[j], array[i]
							break
						end
					end
					print "\r#{(((i + 1).to_f / array.size.to_f) * 100).round}%"
				end
				print "\n"
				array
			end

			def defrag!(block_fmt_data)
				defrag(block_fmt_data, mut: true)
			end

			def calculate_checksum(block_fmt_data)
				puts "calculating checksum..."
				checksum = []
				block_fmt_data.each_with_index do |block, i|
					next if block == "."

					checksum << i * block
				end
				checksum.sum
			end

			def full_block_fmt_data(input)
				disc_map = parse_input(input)
				block_fmt_data = []
				disc_map.each_with_index do |data, id|
					blocks, free_space = data
					blocks&.times { block_fmt_data << id }
					free_space&.times { block_fmt_data << "." }
				end
				block_fmt_data
			end

			def part1(input)
				block_fmt_data = full_block_fmt_data(input)
				defrag!(block_fmt_data)
				calculate_checksum(block_fmt_data)
			end

			def part2(input)
				# Your code here
			end

			private

			def parse_input(input)
				input.chars.map(&:to_i).each_slice(2).to_a
			end

		end

	end

end
