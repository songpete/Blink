class Site < ActiveRecord::Base
  attr_accessible :count, :destination, :short_path
  validates_presence_of :destination

  belongs_to :user

  before_save :check_destination_format

  CHARACTERS = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

  # Creates a random string, checks db for duplicate and keeps trying if string already exists.
  def self.generate_string(size=7)
    str = (0...size).map { CHARACTERS[rand(62)] }.join
    Site.find_by_short_path(str) ? Site.generate_string(size) : str
  end

  def set_short_path
    self.short_path = Site.generate_string if self.short_path == nil
  end

  def check_destination_format
    pref = self.destination[0..3]
    self.destination = "www." + self.destination unless pref == "www." || pref == "http"
    self.destination = "http://" + self.destination unless pref == "http"
  end
end
