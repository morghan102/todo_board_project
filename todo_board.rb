require "./list.rb"
require "byebug"


class TodoBoard

  def initialize
    @board = {}
  end


  def get_command
    print "\nEnter a command: "
    command, label, *args = gets.chomp.split(" ")

    #  debugger
    case command
    when "commands"
        list_cmds
    when "mktodo"
        @board[label].add_item(*args)
    when "up"
        @board[label].up(*args.map(&:to_i))
    when "down"
        @board[label].down(*args.map(&:to_i))
    when "swap"
        @board[label].swap(*args.map(&:to_i)) 
    when "sort"
        @board[label].sort_by_date!
    when "priority"
        @board[label].print_priority
    when "print"
        if args.length == 1
            @board[label].print_full_item(*args.map(&:to_i))
        else
            @board[label].print
        end
    when "quit"
        return false
    when "toggle"
        @board[label].toggle_item(*args.map(&:to_i))
    when "rm"
        @board[label].remove_item(*args.map(&:to_i))
    when "purge"
        @board[label].purge
    when "mklist"
        @board[label] = List.new(label)
    when "ls"
        @board.each { |k,v| puts k }
    when "showall"
        @board.each do |label, instance|
            instance.print
        end
    else
        puts "That is not an acceptable command."
        true
    end
  end

  def list_cmds
    puts
    puts "\nHere's what you can command:"
    puts
    puts "mklist <new list label>"
    puts "-"
    puts "mktodo <list label> <title> <deadline> <optional description>"
    puts "-"
    puts "up or down <list label> <index> <optional amount>"
    puts "-"
    puts "swap <list label> <index_1> <index_2>"
    puts "-"
    puts "sort <list label> (this sorts by date)"
    puts "-"
    puts "priority <list label> (this prints what's at the top of your list)"
    puts "-"
    puts "print <list label> <optional index> (if no index is given, this prints the whole lit. If index is given, it prints all info of specified item)"
    puts "-"
    puts "showall (prints all lists)"
    puts "-"
    puts "ls (prints all list labels)"
    puts "-"
    puts "quit"
    puts "-"
    puts "toggle <list label> <index> (this changes item's status to complete)"
    puts "-"
    puts "rm <list label> <index> (deletes chosen item)"
    puts "-"
    puts "purge <list label> (deletes all completed items)"
    puts
    true
  end

  def run
    while get_command
        get_command
        return false if get_command == false
        # quit doesnt quit unless its 2x
        # weird behavior w quit
    end
end

end
TodoBoard.new.run
