# Advent of Code on Ruby

## Setup

* click `Use this template` --> `Create a new repository`
* clone and run `bundle install`
* login to [adventofcode.com](https://adventofcode.com) and get your session cookie
    * _you can get your session cookie from the Application/Storage tab your browser's developer tools_
* run `cp .env.example .env`
* add your session cookie to the `.env` file

## Workflow

* run `rake "aoc:setup[<year>,<day>]"` to auto-generate:
    * a new solution file in `lib/aoc/<year>/day<day>.rb`
    * a new test file in `spec/aoc/<year>/day<day>_spec.rb`
* code your puzzle solution
* run `bundle exec rspec` to test your solution(s)
    * **Note** - the included `AOCClient` will fetch and cache example inputs, actual inputs, and submitted answers directly from adventofcode.com
