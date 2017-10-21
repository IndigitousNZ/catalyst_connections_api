class User
  class Oauth < User
    def self.from_assertion(token)
      user_data = Koala::Facebook::API
                  .new(token, ENV['FACEBOOK_APP_SECRET'])
                  .get_object('me?fields=id,first_name,last_name,email,picture.width(500).height(500)')
      from_omniauth(
        provider: 'facebook',
        uid: user_data['id'],
        extra: { raw_info: user_data.deep_symbolize_keys }
      )
    rescue Koala::Facebook::AuthenticationError, Koala::Facebook::ClientError
      nil
    end

    def self.from_omniauth(auth)
      auth[:extra][:raw_info][:email] ||= "#{auth[:uid]}@#{auth[:provider]}.com"
      where('(provider = ? AND uid = ?) OR email = ?',
            auth[:provider],
            auth[:uid],
            auth[:extra][:raw_info][:email])
        .first_or_initialize.assign_omniauth_attributes(auth)
    end

    def assign_omniauth_attributes(auth)
      assign_new_omniauth_attributes(auth[:extra][:raw_info]) if new_record?
      assign_new_and_existing_omniauth_attributes(auth)
      save!
      self
    end

    private

    def assign_new_omniauth_attributes(info)
      assign_attributes(
        first_name: info[:first_name],
        last_name: info[:last_name],
        email: info[:email],
        avatar_url: info[:picture][:data][:url],
        password: Devise.friendly_token[0, 20]
      )
    end

    def assign_new_and_existing_omniauth_attributes(auth)
      assign_attributes(
        provider: auth[:provider],
        uid: auth[:uid]
      )
    end
  end
end
