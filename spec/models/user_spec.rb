require 'rails_helper'
describe User do
  describe "#create" do
    it "nickname、email、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: " ")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: " ")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: " ")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "passwordが存在してもpassword_confirmationがないと登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "nicknameが7文字以上であれば登録できないこと" do
      user = build(:user, nickname: "a"*7)
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end
    it "nicknameが6文字以下では登録できること" do
      user = build(:user, nickname: "a"*6)
      expect(user).to be_valid
    end
    it "重複したemailが存在する場合、登録できないこと" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "a"*6, password_confirmation: "a"*6)
      expect(user).to be_valid
    end
    it "passwordが5文字以下では登録できないこと" do
      user = build(:user, password: "a"*5, password_confirmation: "a"*5)
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end