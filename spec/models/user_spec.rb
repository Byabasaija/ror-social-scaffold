require 'rails_helper'

RSpec.describe User, type: :model do
  let(:pascal) { User.create(name: 'Pascal', email: 'pascal3@mail.com', password: '123456') }
  let(:dipesh) { User.create(name: 'dipesh', email: 'dipesh3@mail.com', password: '123456') }
  let(:dipnew) { User.create(name: 'dipnew', email: 'dipnew3@mail.com', password: '123456') }
  let(:pascalnew) { User.create(name: 'pascalnew', email: 'pascalnew@mail.com', password: '123456') }

  let(:friendship1) { pascal.inverse_friendships.create(user: dipesh, confirmed: true) }
  let(:friendship2) { dipesh.inverse_friendships.create(user: dipnew) }
  let(:friendship3) { pascal.inverse_friendships.create(user: dipnew) }
  let(:friendship4) { pascalnew.inverse_friendships.create(user: pascal) }
  it 'it expects pascals friends not to be nil' do
    expect(pascal.friends).not_to eq(nil)
  end
  it 'expects pascals friends to be an array' do
    expect(pascal.friends.is_a?(Array)).to eq(true)
  end

  it "returns dipnew's pending friends" do
    friendship3
    expect(dipnew.pending_friends[0]).to eq(pascal)
  end

  it "Checks if dipnew's pending friends is nil" do
    friendship3
    expect(dipnew.pending_friends[0]).not_to eq(nil)
  end

  it "Checks if dipnew's friend requests is nil" do
    friendship3
    expect(dipnew.friend_requests[0]).not_to eq(nil)
  end

  it "Checks if dipnew's friend requests is nil" do
    friendship3
    expect(dipnew.friend_requests[0]).to eq(dipnew)
  end

  it 'checks if friendship2 is confirmed' do
    friendship2
    expect(dipnew.confirm_friend(dipesh)).to eq(true)
  end

  it 'checks if friendship4 has been rejected' do
    friendship4
    expect(pascal.reject_friend(pascalnew)).to eq(friendship4)
  end

  it 'Checks if request has been recieved' do
    friendship3
    expect(dipnew.request_received[0]).not_to eq(nil)
  end

  it 'Checks if request has been recieved' do
    friendship3
    expect(dipnew.request_received[0]).to eq(pascal)
  end

  it 'Checks if request has been sent' do
    friendship3
    expect(pascal.request_sent[0]).to eq(dipnew)
  end

  it 'Checks if request has been sent? is true' do
    friendship3
    expect(pascal.request_sent?(dipnew)).to eq(true)
  end

  it 'Checks if request has been sent? is true' do
    friendship3
    expect(pascal.request_sent?(dipnew)).not_to eq(false)
  end

  it 'Checks if request has been recieved? is true' do
    friendship3
    expect(dipnew.request_received?(pascal)).to eq(true)
  end

  it 'Checks if request has been recieved? is true' do
    friendship3
    expect(dipnew.request_received?(pascal)).not_to eq(false)
  end

  it 'Checks if a friendship between users exists' do
    friendship3
    expect(dipnew.friends?(pascal)).to eq(false)
  end

  it 'Checks if a friendship between users exists' do
    friendship1
    expect(pascal.friends?(dipesh)).to eq(true)
  end
end
