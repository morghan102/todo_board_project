class Item

  def self.valid_date?(date_str)
    alpha = ("a".."z").to_a
    #includes letters?
    date_str.each_char do |char|
        if alpha.include?(char)
            print "That date is invalid.\n"
            return false
        end
    end
    #formatting correct?
    if date_str[5..6].to_i > 12 || date_str[5..6].to_i == 0 || date_str[8..9].to_i > 31 || date_str[8..9].to_i == 0 || date_str[0..3].to_i <= 0 || date_str[4] != "-" || date_str[7] != "-" || date_str.length != 10
        print "That date is invalid.\n"
        return false
    end
    true
  end

  def self.valid_title?(title)
    if title.length >= 10
      p "That item name is too long"
      return false
    end
    true
  end



  attr_accessor :title, :description
  attr_reader :deadline
  
  
  
  def initialize(title, deadline, description)
    if !Item.valid_title?(title)
      raise "Please choose a shorter name."
    else
      @title = title
    end
    @description = description
    if !Item.valid_date?(deadline)
        raise "Please reenter a date."
    else
        @deadline = deadline
    end
  end
  

  
  def deadline=(new_deadline)
    if !Item.valid_date?(new_deadline)
        raise "Please reenter a date."
    else
        @deadline = new_deadline
    end

  end
  
end