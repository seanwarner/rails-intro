class Movie < ActiveRecord::Base

  attr_accessible :title, :rating, :description, :release_date

  def self.all_ratings
    #gather unique ratings from the table, and sort
    self.pluck(:rating).uniq.sort
  end

  def self.all_ratings_hash
    # Create a hash with the rating as the key and a value of 1 as
    # value. This relates to checkboxes in a view and is intended for
    # initialization of persistent data
    Hash[ *self.all_ratings
               .collect { |val| [val, 1]}
               .flatten  ]
  end

end
