class UserVolume < ApplicationRecord
  belongs_to :user
  belongs_to :volume
end
