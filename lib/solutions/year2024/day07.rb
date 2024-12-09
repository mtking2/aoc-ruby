require "aoc_client"

module Solutions

	module Year2024

		class Day07

			YEAR = 2024
			DAY = 7

			def part1(input)
				equations = parse_input(input)
				total = 0

				equations.each do |equation|
					num_opts = equation[:nomials].length - 1
					["+", "*"].repeated_permutation(num_opts).each do |operator_set|
						set_total = equation[:nomials].first
						operator_set.each_with_index do |operator, i|
							set_total = set_total.send(operator, equation[:nomials][i + 1])
						end
						if set_total == equation[:value]
							total += set_total
							break
						end
					end
				end
				total
			end

			def part2_serial(equations)
				total = 0

				equations.each_with_index do |equation, eq_idx|
					num_opts = equation[:nomials].length - 1
					op_sets = ["+", "*", "||"].repeated_permutation(num_opts)
					op_sets.each do |operator_set|
						set_total = equation[:nomials].first
						operator_set.each_with_index do |operator, i|
							set_total = if operator == "||"
								(set_total.to_s + equation[:nomials][i + 1].to_s).to_i
							else
								set_total.send(operator, equation[:nomials][i + 1])
							end
						end

						if set_total == equation[:value]
							total += set_total
							break
						end
					end
					# print "\r#{eq_idx + 1}/#{equations.length}"
				end
				total
			end

			def part2_parallel(equations)
				# Number of processes
				num_processes = (equations.size > 100) ? 4 : 2

				# Split the array into chunks for each process
				chunk_size = (equations.size / num_processes.to_f).ceil
				chunks = equations.each_slice(chunk_size).to_a

				# Temporary files for inter-process communication
				temp_files = Array.new(num_processes) { Tempfile.new }

				# Forking two processes
				pids = chunks.each_with_index.map do |chunk, index|
					Process.fork do
						total = 0
						chunk.each_with_index do |equation, eq_idx|
							num_opts = equation[:nomials].length - 1
							op_sets = ["+", "*", "||"].repeated_permutation(num_opts)
							op_sets.each do |operator_set|
								set_total = equation[:nomials].first
								operator_set.each_with_index do |operator, i|
									set_total = if operator == "||"
										(set_total.to_s + equation[:nomials][i + 1].to_s).to_i
									else
										set_total.send(operator, equation[:nomials][i + 1])
									end
								end

								if set_total == equation[:value]
									total += set_total
									break
								end
							end
							# puts "[T#{index}] #{eq_idx + 1}/#{chunk.size}"
						end

						# Write results to the temporary file
						temp_files[index].write(Marshal.dump(total))
						temp_files[index].close
					end
				end

				# Wait for child processes to complete
				pids.each { |pid| Process.wait(pid) }

				# Collect results from the temporary files
				total = temp_files.flat_map do |file|
					file.open # Reopen the file for reading
					data = file.read
					Marshal.load(data) unless data.empty? # Handle empty files gracefully
				end.sum

				# Close and unlink temporary files to clean up
				temp_files.each(&:unlink)

				# binding.b
				total
			end

			def part2(input)
				equations = parse_input(input)

				# part2_serial(equations)
				part2_parallel(equations)
			end

			private

			def parse_input(input)
				equations = []
				input.each_line.map do |line|
					value_str, nomials_str = line.split(":")
					value = value_str.to_i
					nomials = nomials_str.strip.split(" ").map(&:to_i)
					equations << {
						value: value,
						nomials: nomials
					}
				end
				equations
			end

		end

	end

end
