class User < ApplicationRecord
  validates :account, precedence: true, uniqueness: { case_sensitive: false }
end
