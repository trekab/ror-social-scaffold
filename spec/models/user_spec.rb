require 'rails_helper'

RSpec.describe User, type: :model do
	subject do
		User.new(name: 'jonsnow',
		         email: 'jonsnow@ymail.com',
		         password: 'password')
  end

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'should have a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end
