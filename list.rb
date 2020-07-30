require "./item.rb"
require "byebug"

class List

  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end
  
  def add_item(title, deadline, *description)
    if !Item.valid_date?(deadline) || !Item.valid_title?(title)
      return false
    else
      @items << Item.new(title, deadline, description)
    end
    true
  end

  def size
    @items.length
  end

  def valid_index?(idx)
  0 <= idx && idx < self.size
  end


  def swap(idx_1, idx_2)
    return false if !valid_index?(idx_1) || !valid_index?(idx_2)
    @items[idx_1], @items[idx_2] = @items[idx_2], @items[idx_1]
    true
  end


  def [](idx)
    return nil if !valid_index?(idx)
    @items[idx]
  end


  def priority
    @items[0]
  end


  def print
    puts "-------------------------".rjust(29)
    puts @label.upcase.rjust(16) 
    puts "---------------".rjust(23)
    puts "Item     |  Deadline  |  Done  |  Description"
    puts "-----".rjust(19)
    
    @items.each do |item|
      if item.done
        doneness = "Yes"
      else
        doneness = "No"
      end
      puts item.title.ljust(12) + item.deadline.ljust(14) + doneness.ljust(7) + item.description.join(" ")
    end
    puts "-------------------------".rjust(29)
    true
  end


  def print_full_item(idx)

    return false if !valid_index?(idx)
    puts
    puts "- - - - -"
    puts "Title: #{@items[idx].title}"
    puts "Deadline: #{@items[idx].deadline}"
    puts "Complete? #{@items[idx].done}"
    puts "Description: #{@items[idx].description.join(" ")}"
    puts "- - - - -"
    puts
    true
  end

  def print_priority
    print_full_item(0)
    true
  end

  def up(idx, amount=1)
    return false if !valid_index?(idx)
    i = 0
    while i < amount
      swap(idx, idx - 1)
      idx -= 1
      i += 1
    end
    true
  end

  def down(idx, amount=1)
    return false if !valid_index?(idx)
    amount = (self.size - 1 - idx) if amount >= self.size

    i = 0 #n is num of times swap happens
    while i < amount
      swap(idx, idx + 1)
      idx += 1
      i += 1
    end
    true
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
    true
  end

  def toggle_item(idx)
     @items[idx].toggle
  end

  def remove_item(idx)
    return false if !valid_index?(idx)
    
    @items.delete_at(idx)
    true
  end

  def purge
    i = 0
    while i < @items.size
      if @items[i].done
        remove_item(i)
        return true if @items.size == 0
      else
        i += 1
      end
    end
    true
  end

end