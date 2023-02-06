class SerialCodeNumberOfDigitsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.between?(8, 16)
      record.errors.add(attribute, options[:message] || :out_of_range)
    end
  end
end
