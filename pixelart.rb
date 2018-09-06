#!/usr/bin/env ruby

require 'date'
require 'securerandom'

SUBVERSIVE_MESSAGE = "
                                                   
 ####  ###  ###    ##   ## #### ##### #### # #### #
 #  # #   # #  #   # # # # #      #   #  # # #    #
 ###  ##### #  #   #  #  # ###    #   # #  # #    #
 #  # #   # #  #   #     # #      #   #  # # #    
 ###  #   # ###    #     # ####   #   #  # # #### #
                                                   
"

def main
  Dir.chdir(File.dirname(__FILE__))

  root_commit = `git rev-list HEAD --reverse | head -1`.chomp
  system("git", "reset", "--hard", root_commit)

  start = Date.today - 365
  while start.wday > 0
    start -= 1
  end

  # light flood fill
  # (start..Date.today).each do |day|
  #   (rand(5) + 1).times do
  #     nonce = SecureRandom.hex
  #     File.write(File.join(File.dirname(__FILE__), "README.txt"),
  #                nonce)
  #     system("git", "add", "README.txt")
  #     system("git", "commit", "-m", nonce, "--date", day.strftime)
  #   end
  # end

  # subversive message
  grid = SUBVERSIVE_MESSAGE.chomp.split("\n").drop(1).map {|r| r.split("")}

  rows = 7
  cols = 51

  day = start
  cols.times do |col|
    rows.times do |row|
      if grid[row][col] == '#'
        45.times do
          nonce = SecureRandom.hex
          File.write(File.join(File.dirname(__FILE__), "README.txt"),
                     nonce)
          system("git", "add", "README.txt")
          system("git", "commit", "-m", nonce, "--date", day.strftime)
        end
      end

      day += 1
    end
  end
end


main
