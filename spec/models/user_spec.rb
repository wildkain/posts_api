require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :nickname }
  it { should validate_presence_of :email }
  it { should have_secure_password }
  it { should have_many(:comments).dependent(:destroy)}
  it { should have_many(:posts).dependent(:destroy)}
end
