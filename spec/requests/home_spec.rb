require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it { should route(:get, '/').to(action: :page) }
  it { should route(:post, '/').to(action: :subscribe_user) }
end
