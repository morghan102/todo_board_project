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

    if !Item.valid_date?(deadline)
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

  # def [](idx)
  #   return nil if !valid_index?(idx)
  #   @items[idx]
  # end

end