require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  it { should route(:get, '/users/sign_in').to(action: :new) }
  it { should route(:post, '/users/sign_in').to(action: :create) }
  it { should route(:delete, '/users/sign_out').to(action: :destroy) }
end
