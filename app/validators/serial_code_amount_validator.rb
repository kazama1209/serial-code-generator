class SerialCodeAmountValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value > 5000
      record.errors.add(attribute, options[:message] || :less_than_5000)
    end
  end
end
