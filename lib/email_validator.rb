require 'net/http'
require 'net/https'

class EmailValidator
  def self.validate_email(email)
    uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=#{Rails.application.credentials.email_validation.api_key}&email=#{email}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request =  Net::HTTP::Get.new(uri)

    response = http.request(request)
    OpenStruct.new({ success?: true, response: response })
  rescue StandardError => e
    Rails.logger.error "Error: #{e}"
    OpenStruct.new({ success?: false, response: e })
  end
end
