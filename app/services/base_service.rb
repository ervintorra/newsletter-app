class BaseService
  def self.call(*args, &block)
    new(*args, &block).execute
  end

  private

  def success_response(resource: nil, message: nil)
    ServiceResponse.new(success: true, resource: resource, message: message)
  end

  def unsuccess_response(resource: nil, message: nil)
    ServiceResponse.new(success: false, resource: resource, message: message)
  end
end
