class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'Must be a valid URL') unless url_valid?(value)
  end

  # a URL may be technically well-formed but may
  # not actually be valid, so this checks for both.
  def url_valid?(url)
    return false unless url_regexp?(url)

    url = begin
            URI.parse(url)
          rescue URI::InvalidURIError
            false
          end
    (url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)) && !url.host.nil?
  end

  def url_regexp?(url)
    url_regexp = url.strip.match(%r{^(http|https)://[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?$}ix)
    return true  unless url_regexp.nil?

    false
  end
end
