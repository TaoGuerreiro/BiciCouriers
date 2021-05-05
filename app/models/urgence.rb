class Urgence < Option
    has_many :delivery_options
    has_many :deliveries, through: :delivery_options
end
