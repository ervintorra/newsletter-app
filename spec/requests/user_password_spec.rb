require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  # it { should use_before_action(:authenticate_user) }
  it { should route(:get, '/users/password/new').to(action: :new) }
  it { should route(:post, '/users/password').to(action: :create) }
  it { should route(:get, '/users/password/edit').to(action: :edit) }
  it { should route(:patch, '/users/password').to(action: :update) }
end
