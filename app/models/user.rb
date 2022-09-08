class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :omniauthable, omniauth_providers: [:authsch]

  def self.from_omniauth(access_token)
    data = access_token.extra.raw_info
    user = User.find_by(authsch_id: data.internal_id,)

    unless user
      user = User.create(name: data.displayName,
                         email: data.mail,
                         authsch_id: data.internal_id,
                         password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
