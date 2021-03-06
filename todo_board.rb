require "./list.rb"
require "byebug"


class TodoBoard

  def initialize(label)
    @list = List.new(label)
  end

# A small detail we can worry about later is that the user will 
# enter their command with spaces separating their arguments. 
# This will cause issues if they use any spaces within the text 
# for the todo's title or description. We'll ignore this caveat for 
# now.
  def get_command
    print "\nEnter a command: "
    command, *args = gets.split(" ") #need chomp?

    # debugger
    case command
    when "commands"
        list_cmds
    when "mktodo"
        @list.add_item(*args) 
    when "up"
        @list.up(*args.map(&:to_i))
    when "down"
        @list.down(*args.map(&:to_i))
    when "swap"
        @list.swap(*args.map(&:to_i)) 
    when "sort"
        @list.sort_by_date!
    when "priority"
        @list.print_priority
    when "print"
        if args.length == 1
            @list.print_full_item(*args.map(&:to_i))
        else
            @list.print
        end
    when "quit"
        return false
    else
        puts "That is not an acceptable command."
    end
    # true
  end

  def list_cmds
    puts
    puts "\nHere's what you can command:"
    puts
    puts "mktodo <title> <deadline> <optional description>"
    puts "-"
    puts "up or down <index> <optional amount>"
    puts "-"
    puts "swap <index_1> <index_2>"
    puts "-"
    puts "sort (this sorts by date)"
    puts "-"
    puts "priority (this prints what's at the top of your list)"
    puts "-"
    puts "print <optional index> (if no index is given, this prints the whole lit. If index is given, it prints all info of specified item)"
    puts "-"
    puts "quit"
    puts
  end

  def run
    while get_command != false
        get_command
    end
end

end
