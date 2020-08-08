class Type < ApplicationRecord
    validates :material, presence: true, length: {minimum: 5}
    validates :remarks, presence: true, length: {minimum: 3}
    validates :weight, presence: true, length: {minimum: 1}
end