namespace :aoc do
	desc "Set up files for a specific year/day"
	task :setup, [:year, :day] do |t, args|
		year = args[:year] || Time.now.year
		day = args[:day] || Time.now.day
		day_formatted = format("%02d", day)
		dir = "lib/solutions/year#{year}"
		filename = "day#{day_formatted}.rb"
		full_path = "#{dir}/#{filename}"

		FileUtils.mkdir_p(dir)
		File.write(full_path, <<~RUBY) unless File.exist?(full_path)
			require "aoc_client"

			module Solutions

				module Year#{year}

					class Day#{day_formatted}

						YEAR = #{year}
						DAY = #{day}

						def part1(input)
							# Your code here
						end

						def part2(input)
							# Your code here
						end

						private

						def parse_input(input)
							# Process the input and return the result
						end

					end

				end

			end
		RUBY

		puts "created #{full_path}"

		spec_dir = "spec/solutions/year#{year}"
		spec_filename = "day#{day_formatted}_spec.rb"
		spec_full_path = "#{spec_dir}/#{spec_filename}"
		FileUtils.mkdir_p(spec_dir)
		File.write(spec_full_path, <<~RUBY) unless File.exist?(spec_full_path)
			require "rspec"
			require "solutions/year#{year}/day#{day_formatted}"

			RSpec.describe Solutions::Year#{year}::Day#{day_formatted} do
				subject(:solution) { described_class.new }

				let(:actual_input) { AOCClient.fetch_input(described_class::YEAR, described_class::DAY) }

				describe "constants" do
					it "has the correct year" do
						expect(described_class::YEAR).to eq(#{year})
					end

					it "has the correct day" do
						expect(described_class::DAY).to eq(#{day})
					end
				end

				describe "#part1" do
					context "with example input" do
						it "returns the expected result" do
							example_input_part_one = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 1)
							expect(solution.part1(example_input_part_one)).to eq("TODO")
						end
					end

					context "with actual input" do
						it "returns the correct answer" do
							skip("TODO")
							part1_answer = AOCClient.fetch_answer(described_class::YEAR, described_class::DAY, 1)
							expect(solution.part1(actual_input)).to eq(part1_answer)
						end
					end
				end

				describe "#part2" do
					context "with example input" do
						it "returns the expected result" do
							skip("TODO")
							example_input_part_two = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 2)
							expect(solution.part2(example_input_part_two)).to eq("TODO")
						end
					end

					context "with actual input" do
						it "returns the correct answer" do
							skip("TODO")
							part2_answer = AOCClient.fetch_answer(described_class::YEAR, described_class::DAY, 2)
							expect(solution.part2(actual_input)).to eq(part2_answer)
						end
					end
				end
			end
		RUBY
		puts "created #{spec_full_path}"

		puts "Setup complete for #{year} Day #{day_formatted}"
	end
end
