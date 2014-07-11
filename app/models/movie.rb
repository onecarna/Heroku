class Movie < ActiveRecord::Base
validates :title, :description, presence: true #ensures no blanks
validates :description, length: { minimum: 10 }
validates :year_released, numericality: true, length: { is: 4, :message => " must be 4 numbers" }
validates :rating, numericality: true, inclusion: { in: 1..6, :message => " must be between 1 and 6" }
#error messages are generated automatically for us, no need to write out
  def self.search_for(query)
    where('title LIKE :query OR description LIKE :query', query: "%#{query}%")
  end
end
