require "rspec"
require "solutions/year2024/day10"

RSpec.describe Solutions::Year2024::Day10 do
	subject(:solution) { described_class.new }

	let(:actual_input) { AOCClient.fetch_input(described_class::YEAR, described_class::DAY) }

	describe "constants" do
		it "has the correct year" do
			expect(described_class::YEAR).to eq(2024)
		end

		it "has the correct day" do
			expect(described_class::DAY).to eq(10)
		end
	end

	describe "#part1" do
		context "with example input" do
			it "returns the expected result for example 1" do
				example_input_part_one = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 1)
				expect(solution.part1(example_input_part_one)).to eq(1)
			end

			it "returns the expected result for example 2" do
				example_input_part_one = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 2)
				expect(solution.part1(example_input_part_one)).to eq(2)
			end

			it "returns the expected result for example 3" do
				example_input_part_one = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 3)
				expect(solution.part1(example_input_part_one)).to eq(4)
			end

			it "returns the expected result for example 4" do
				example_input_part_one = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 4)
				expect(solution.part1(example_input_part_one)).to eq(3)
			end

			it "returns the expected result for example 5" do
				example_input_part_one = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 5)
				expect(solution.part1(example_input_part_one)).to eq(36)
			end
		end

		context "with actual input" do
			it "returns the correct answer" do
				part1_answer = AOCClient.fetch_answer(described_class::YEAR, described_class::DAY, 1)
				expect(solution.part1(actual_input)).to eq(part1_answer)
			end
		end
	end

	describe "#part2" do
		context "with example input" do
			it "returns the expected result" do
				example_input_part_two = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 5)
				expect(solution.part2(example_input_part_two)).to eq(81)
			end
		end

		context "with actual input" do
			it "returns the correct answer" do
				part2_answer = AOCClient.fetch_answer(described_class::YEAR, described_class::DAY, 2)
				expect(solution.part2(actual_input)).to eq(part2_answer)
			end
		end
	end
end
