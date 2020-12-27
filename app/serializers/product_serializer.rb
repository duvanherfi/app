class ProductSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :precio, :cantidad, :stock, :description
end
