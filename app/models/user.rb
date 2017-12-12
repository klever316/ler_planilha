class User < ActiveRecord::Base  
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :ldap_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
    validates :username, presence: true, uniqueness: true
    before_validation :get_ldap_email
    
    def get_ldap_email
        if Devise::LDAP::Adapter.get_ldap_param(self.username, 'mail') 
            self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
        else
            self.email = "#{username}@tjce.jus.br"
        end

        if Devise::LDAP::Adapter.get_ldap_param(self.username,"cn")
            puts Devise::LDAP::Adapter.get_ldap_param(self.username,"cn").inspect
            self.name = Devise::LDAP::Adapter.get_ldap_param(self.username,"cn").first.force_encoding("utf-8")
        end
    end

    # hack for remember_token
    def authenticatable_token
        Digest::SHA1.hexdigest(email)[0,29]
    end
end