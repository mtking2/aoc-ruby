require "rspec"
require "solutions/year2024/day11"

RSpec.describe Solutions::Year2024::Day11 do
	subject(:solution) { described_class.new }

	let(:actual_input) { AOCClient.fetch_input(described_class::YEAR, described_class::DAY) }

	describe "constants" do
		it "has the correct year" do
			expect(described_class::YEAR).to eq(2024)
		end

		it "has the correct day" do
			expect(described_class::DAY).to eq(11)
		end
	end

	describe "#part1" do
		context "with the first example input" do
			let(:example_input_part_one) { AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 1) }

			it "returns the expected result" do
				expect(solution.part1(example_input_part_one, 1)).to eq(7)
			end
		end

		context "with the second example input" do
			let(:example_input_part_one) { AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 2) }

			it "returns the expected result after 6 iterations" do
				expect(solution.part1(example_input_part_one, 6)).to eq(22)
			end

			it "returns the expected result after 25 iterations" do
				expect(solution.part1(example_input_part_one, 25)).to eq(55312)
			end
		end

		context "with actual input" do
			it "returns the correct answer" do
				part1_answer = AOCClient.fetch_answer(described_class::YEAR, described_class::DAY, 1)
				expect(solution.part1(actual_input, 25)).to eq(part1_answer)
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
