# lib/aoc_client.rb

require "httparty"
require "nokogiri"
require "fileutils"
require "dotenv/load"

module AOCClient

	class << self

		AOC_URL = "https://adventofcode.com"

		def fetch_input(year, day)
			fetch_and_cache(year, "input_#{day_str(day)}") do
				url = "#{AOC_URL}/#{year}/day/#{day}/input"
				get_authenticated_content(url)
			end
		end

		def fetch_example(year, day, part)
			fetch_and_cache(year, "example_#{day_str(day)}_#{part}") do
				url = "#{AOC_URL}/#{year}/day/#{day}"
				page_content = get_authenticated_content(url)
				parse_example_from_page(page_content, part)
			end
		end

		def fetch_answer(year, day, part)
			fetch_and_cache(year, "answer_#{day_str(day)}_#{part}") do
				url = "#{AOC_URL}/#{year}/day/#{day}"
				page_content = get_authenticated_content(url)
				parse_answer_from_page(page_content, part)
			end.to_i
		end

		private

		def get_authenticated_content(url)
			session = ENV["AOC_SESSION"]
			unless session
				raise "AOC_SESSION environment variable is not set."
			end

			headers = {
				"Cookie" => "session=#{session}"
			}

			response = HTTParty.get(url, headers: headers, debug_output: $stdout)

			unless response.success?
				puts "Response Code: #{response.code}"
				puts "Response Message: #{response.message}"
				puts "Response Body: #{response.body}"
				raise "Failed to fetch content from #{url}. HTTP Status: #{response.code}"
			end

			response.body
		end

		def fetch_and_cache(year, filename)
			cache_dir = ".cache/#{year}"
			FileUtils.mkdir_p(cache_dir)
			cache_file = "#{cache_dir}/#{filename}"

			if File.exist?(cache_file)
				File.read(cache_file)
			else
				content = yield
				File.write(cache_file, content) if !content.nil?
				content
			end
		end

		def parse_example_from_page(page_content, part)
			doc = Nokogiri::HTML(page_content)
			examples = doc.css("pre").map(&:text)
			example_index = part.to_i - 1
			examples[example_index] || nil
		end

		def parse_answer_from_page(page_content, part)
			doc = Nokogiri::HTML(page_content)
			answer_elements = doc.xpath("//*[contains(text(), 'Your puzzle answer was')]")
			answers = []
			answer_elements.each do |element|
				codes = element.css("code")
				codes.each do |code|
					answers << code.text
				end
			end
			answer_index = part.to_i - 1
			answers[answer_index] || nil
		end

		def day_str(day)
			day.to_s.rjust(2, "0")
		end

	end

end
