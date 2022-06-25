class ServiceResponse
  attr_writer :success
  attr_accessor :resource, :message

  def initialize(success: nil, resource: nil, message: nil)
    @success = success
    @resource = resource
    @message = message
  end

  def success?
    @success
  end
end
