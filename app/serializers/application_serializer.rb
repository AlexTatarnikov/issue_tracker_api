class ApplicationSerializer < ActiveModel::Serializer
  def type
    object.class.name.underscore
  end
end
