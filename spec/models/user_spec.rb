require 'rails_helper'

RSpec.describe User, type: :model do
  let(:pascal) { User.create(name: 'Pascal', email: 'pascal3@mail.com', password: '123456') }
  let(:dipesh) { User.create(name: 'dipesh', email: 'dipesh3@mail.com', password: '123456') }
  let(:dipnew) { User.create(name: 'dipnew', email: 'dipnew3@mail.com', password: '123456') }
  let(:pascalnew) { User.create(name: 'pascalnew', email: 'pascalnew@mail.com', password: '123456') }

  let(:friendship1) { pascal.friends << dipesh }
  let(:friendship2) { dipesh.friends << dipnew }
  let(:friendship3) { pascal.friends << dipnew }

  it 'it expects pascals friends not to be nil' do
    expect(pascal.friends).not_to eq(nil)
  end

  it 'it expects dipesh friends not to be nil' do
    expect(dipesh.friends).not_to eq(nil)
  end

  it 'it expects pascal to have 2 friends' do
    friendship1
    friendship3
    expect(pascal.friends.count).to eq(2)
  end

  it 'checks if friendship2 is confirmed' do
    dipnew.confirm_friend(pascalnew)
    expect(dipnew.friends?(pascalnew)).to eq(true)
  end

  it 'Checks if a friendship between users exists' do
    friendship3
    expect(dipnew.friends?(pascal)).to eq(true)
  end

  it "Checks if a friendship between users doesn't exists" do
    expect(pascal.friends?(pascalnew)).to eq(false)
  end
end
