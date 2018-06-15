# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject (:user) { FactoryBot.create :user }

  describe 'validations' do
    it { should validate_presence_of :username }
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :session_token }

    it { should validate_uniqueness_of :username }
    it { should validate_length_of(:password).is_at_least(6) }

    describe '::find_by_credentials' do
      context 'successful' do
        it "should find by credentials" do
          user1 = User.find_by_credentials(user.username, user.password)
          expect(user1).to eq(user)
        end
      end

      context 'failure' do
        it 'should not find by credentials' do
          user1 = User.find_by_credentials("user.username", "user.password")
          expect(user1).to be(nil)
        end
      end
    end

    describe '#is_password?' do
      context 'successful' do
        it "should return true" do
          expect(user.is_password?(user.password)).to be(true)
        end
      end

      context 'failure' do
        it 'should return false' do
          expect(user.is_password?('user.password')).to be(false)
        end
      end
    end

    describe '#reset_token!' do
      it "should reset the token" do
        token1 = user.session_token.dup
        user.reset_token!
        expect(token1).not_to eq(user.session_token)
      end
    end

    describe '#generate_token!' do
      it "should give uniqe tokens" do
        expect(User.generate_token).not_to eq(User.generate_token)
      end
    end

  end
end
