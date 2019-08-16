class CreditCardExpirationValidator < ActiveModel::EachValidator
  EXPIRATION_DATE_REGEX = %r{\A(0[1-9]|1[0-2])/([0-9]{2}|[0-9]{2})\z}.freeze
  MONTH_RANGE = (1..12).freeze

  def validate_each(record, attribute, value)
    validate_format(record, attribute, value)

    return if record.errors[attribute].any?

    valiate_date(record, attribute, value)
  end

  private

  def validate_format(record, attribute, value)
    add_error(record, attribute, :invalid_expiration_date) unless value.to_s.match?(EXPIRATION_DATE_REGEX)
  end

  def valiate_date(record, attribute, value)
    parse_date(value)

    set_current_year_and_month

    add_error(record, attribute, :expired) unless month_valid? && year_valid?
  end

  def parse_date(value)
    @month, @year = value.split(47.chr).map(&:to_i)
  end

  def set_current_year_and_month
    @current_year = Time.zone.now.year.digits.reverse.last(2).join.to_i
    @current_month = Time.zone.now.month
  end

  def month_valid?
    return MONTH_RANGE.include?(@month) && @month > @current_month if @year == @current_year

    MONTH_RANGE.include?(@month)
  end

  def year_valid?
    @year >= @current_year
  end

  def add_error(record, attribute, error)
    record.errors.add(attribute, I18n.t("validation_errors.credit_card.#{error}"))
  end
end
