require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do
  it { should route(:get, '/subscribers').to(action: :index) }
  it { should route(:get, '/subscribers/new').to(action: :new) }
  it { should route(:post, '/subscribers').to(action: :create) }
  it { should route(:get, '/subscribers/1').to(action: :show, id: 1) }
  it { should route(:get, '/subscribers/1/edit').to(action: :edit, id: 1) }
  it { should route(:patch, '/subscribers/1').to(action: :update, id: 1) }
  it { should route(:delete, '/subscribers/1').to(action: :destroy, id: 1) }
  it { should route(:get, '/subscribers/confirm').to(action: :confirm) }
end
