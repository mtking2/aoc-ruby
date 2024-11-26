require "aoc_client"

module Solutions

	module Year2023

		class Day07

			YEAR = 2023
			DAY = 7

			CARD_VALUES_HEX = {
				"2" => "2",
				"3" => "3",
				"4" => "4",
				"5" => "5",
				"6" => "6",
				"7" => "7",
				"8" => "8",
				"9" => "9",
				"T" => "a",
				"J" => "b",
				"Q" => "c",
				"K" => "d",
				"A" => "e"
			}

			CARD_VALUES_HEX_JOKER_WC = CARD_VALUES_HEX.dup.tap { |h| h["J"] = "1" }

			RANKS = {
				"11111" => 1, # High Card
				"2111" => 2, # Pair
				"221" => 3, # Two Pair
				"311" => 4, # Three of a Kind
				"32" => 5, # Full House
				"41" => 6, # Four of a Kind
				"5" => 7 # Five of a Kind
			}

			def max_positional_score
				@max_positional_score ||= calculate_positional_score("AAAAA").to_f
			end

			def calculate_rank(hand, wildcard_jokers: false)
				counts = hand.chars.tally.sort_by(&:last).reverse
				if wildcard_jokers && hand.include?("J") && hand != "JJJJJ"
					possible_subs = hand.delete("J").chars.uniq
					possible_hands = possible_subs.map { |sub| hand.gsub("J", sub) }
					ranks_of_possible_hands = possible_hands.map do |possible_hand|
						counts = possible_hand.chars.tally.sort_by(&:last).reverse
						RANKS[counts.to_h.values.join]
					end
					ranks_of_possible_hands.max
				else
					RANKS[counts.to_h.values.join]
				end
			end

			def calculate_positional_score(hand, wildcard_jokers: false)
				card_values_hex = wildcard_jokers ? CARD_VALUES_HEX_JOKER_WC : CARD_VALUES_HEX
				hand.chars.map { |card| card_values_hex[card] }.join.to_i(16)
			end

			def get_total_winnings(set, wildcard_jokers: false)
				set = parse_input(set)

				set.each do |hand|
					rank = calculate_rank(hand[:hand], wildcard_jokers: wildcard_jokers)
					positional_score = calculate_positional_score(hand[:hand], wildcard_jokers: wildcard_jokers)
					overall_score = rank + (positional_score / max_positional_score)

					hand[:rank] = rank
					hand[:positional_score] = positional_score
					hand[:overall_score] = overall_score
				end

				total = 0
				sorted_hands = set.sort_by { |s| s[:overall_score] }

				# puts
				# sorted_hands.reverse_each do |hand|
				# 	puts hand
				# end
				# puts

				sorted_hands.each_with_index do |hand, index|
					total += hand[:bid] * (index + 1)
				end
				total
			end

			def part1(input)
				get_total_winnings(input)
			end

			def part2(input)
				get_total_winnings(input, wildcard_jokers: true)
			end

			private

			def parse_input(input)
				set = []
				input.each_line do |line|
					hand, bid = line.strip.split(" ")
					set << {
						hand: hand,
						bid: bid.to_i
					}
				end
				set
			end

		end

	end

end
