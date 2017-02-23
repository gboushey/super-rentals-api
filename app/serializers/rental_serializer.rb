class RentalSerializer < ActiveModel::Serializer
  attributes :id,  
    :title,
    :owner,
    :city,
    :bedrooms,
    :image,
    :description
end
