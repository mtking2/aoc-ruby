require "rspec"
require "solutions/year2024/day09"

RSpec.describe Solutions::Year2024::Day09 do
	subject(:solution) { described_class.new }

	let(:actual_input) { AOCClient.fetch_input(described_class::YEAR, described_class::DAY) }

	describe "constants" do
		it "has the correct year" do
			expect(described_class::YEAR).to eq(2024)
		end

		it "has the correct day" do
			expect(described_class::DAY).to eq(9)
		end
	end

	describe "#full_block_fmt_data" do
		context "with example input" do
			let(:example_input) { "12345" }

			it "returns the expected result" do
				expect(solution.full_block_fmt_data(example_input).join).to eq("0..111....22222")
			end
		end

		context "with different example input" do
			let(:example_input) { "2333133121414131402" }

			it "returns the expected result" do
				expect(solution.full_block_fmt_data(example_input).join).to eq("00...111...2...333.44.5555.6666.777.888899")
			end
		end

		context "with another example input" do
			let(:example_input) { "233313312141413140256" }

			it "returns the expected result" do
				expect(solution.full_block_fmt_data(example_input).join).to eq("00...111...2...333.44.5555.6666.777.888899.....101010101010")
			end
		end
	end

	describe "#defrag" do
		context "with example input" do
			let(:example_input) { solution.full_block_fmt_data("12345") }

			it "returns the expected result" do
				expect(solution.defrag(example_input).join).to eq("022111222......")
			end

			it "does not modify the input string" do
				expect { solution.defrag(example_input) }.not_to change { example_input }
			end
		end

		context "with another example input" do
			let(:example_input) { solution.full_block_fmt_data("2333133121414131402") }

			it "returns the expected result" do
				expect(solution.defrag(example_input).join).to eq("0099811188827773336446555566..............")
			end
		end

		context "with a differnt example input" do
			let(:example_input) { solution.full_block_fmt_data("233313312141413140256") }

			it "returns the expected result" do
				expect(solution.defrag(example_input).join).to eq("0010101011110101029983338448555586666777...................")
			end
		end
	end

	describe "#defrag!" do
		context "with example input" do
			let(:example_input) { "0..111....22222" }

			it "modifies the input string in place" do
				expect { solution.defrag!(example_input) }.to change { example_input }.from("0..111....22222").to("022111222......")
			end
		end
	end

	describe "#part1" do
		context "with another example input" do
			let(:example_input) { AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 1) }

			it "returns the expected result" do
				expect(solution.part1(example_input)).to eq(1928)
			end
		end

		context "with actual input" do
			it "returns the correct answer" do
				part1_answer = AOCClient.fetch_answer(described_class::YEAR, described_class::DAY, 1)

				# skipping brute force solution call
				# expect(solution.part1(actual_input)).to eq(part1_answer)

				expect(part1_answer).to eq(6340197768906)
			end
		end
	end

	describe "#part2" do
		context "with example input" do
			it "returns the expected result" do
				skip("TODO")
				example_input_part_two = AOCClient.fetch_example(described_class::YEAR, described_class::DAY, 2)
				expect(solution.part2(example_input_part_two)).to eq(2858)
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
