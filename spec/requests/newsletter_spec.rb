require 'rails_helper'

RSpec.describe NewslettersController, type: :controller do
  it { should route(:get, '/newsletters').to(action: :index) }
  it { should route(:get, '/newsletters/new').to(action: :new) }
  it { should route(:post, '/newsletters').to(action: :create) }
  it { should route(:get, '/newsletters/1').to(action: :show, id: 1) }
  it { should route(:get, '/newsletters/1/edit').to(action: :edit, id: 1) }
  it { should route(:patch, '/newsletters/1').to(action: :update, id: 1) }
  it { should route(:delete, '/newsletters/1').to(action: :destroy, id: 1) }
end
