class List
  require "./item.rb"
  require "byebug"

  attr_accessor :label
  # do i need to set to ("new_label")?

  def initialize(label)
    @label = label
    @items = [] #will contain instaces of Item
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
    # i truly cant think of a better way to do this :(
      t_f_arr = []
    @items.each_with_index do |e, i|
      # debugger 
      if i != idx
        t_f_arr << false
      else 
        t_f_arr << true
      end
    end
    return false if t_f_arr.all? { |e| e == false }
    true
  end


  def swap(idx_1, idx_2)
    return false if !valid_index?(idx_1) || !valid_index?(idx_2)

    @items.each_with_index do |ele, i|
      if i == idx_1
        @items[idx_1], @items[idx_2] = @items[idx_2], @items[idx_1]
      end
    end
    true
  end


  def [](idx)
    # not sure if this one works
    return nil if !valid_index?(idx)
    @items[idx]
  end


  def priority
    @items[0]
  end


  def print
    puts "-------------------------".rjust(29)
    puts @label.rjust(25) #!!!!!!!!!
    # this is not centered, diff places depending on length of the label
    puts "---------------".rjust(23)
    puts "Item     |  Deadline  |  Description"
    puts "-----".rjust(19)
    
    @items.each do |item|
      puts item.title.ljust(12) + item.deadline.ljust(14) +item.description.join
    end
    puts "-------------------------".rjust(29)

  end


  def print_full_item(idx)

    return false if !valid_index?(idx)
    puts
    puts "- - - - -"
    puts @items[idx].title
    puts @items[idx].deadline
    puts @items[idx].description
    puts "- - - - -"
    puts
  end

  def print_priority
    print_full_item(0)
  end

# what was their  solution to this? i feel like using times mehod would be best but not sure how to implement
  def up(idx, amount=1)
    return false if !valid_index?(idx) #@items.length < idx + 1 #check if idx is in items
    i = 0
    while i < amount
      swap(idx, idx - 1)
      idx -= 1
      i += 1
    end
    true
    # amount.times { |i| swap(idx, idx - 1) }
  end



  def down(idx, amount=1)
    return false if !valid_index?(idx)

    n = 0 #i is num of times swap happens
    while n < amount
      # debugger
      @items.each_with_index do |ele, i|
        if i == idx
          @items[i], @items[i+1] = @items[i+1], @items[i]
        end
      end
      idx += 1
      n += 1
    end
    true
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
    # @items.print
  end
end