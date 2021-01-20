class Post < ApplicationRecord
  validates :body, length: { minimum: 1, maximum: 300 }
end
