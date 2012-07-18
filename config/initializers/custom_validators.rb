class VanityNameUniquenessValidator < ActiveModel::Validator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "Page name has already been taken" unless value.map(&:name).uniq.size == value.size
  end
end
