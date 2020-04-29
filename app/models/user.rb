class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email, unless: :uid?
  before_create :create_activation_digest
  validates :name,  presence: true, unless: :uid?, length: { maximum: 29 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, unless: :uid?, length: { maximum: 31 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :posts
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: 'post'
  has_many :comments
  has_many :comment_posts, through: :comments, source: 'post'
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true, unless: :uid?
  
    # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
   # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
  update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
    # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
    # アカウントを有効にする
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now )
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  # Twitterログイン認証用
  # def self.find_or_create_from_auth(auth)
  #   provider = auth[:provider]
  #   uid = auth[:uid]
  #   name = auth[:info][:name]
  #   image = auth[:info][:image]

  #   self.find_or_create_by(provider: provider, uid: uid) do |user|
  #     user.name = name
  #     user.image_url = image
  #   end
  # end
  
  # Twitterログイン認証用(メール認証対応)
  def self.find_or_initialize_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    email = "#{('a'..'z').to_a.shuffle[0..10].join}@gmail.com"
    password = "foobar"
    image_url = auth[:info][:image]

    self.find_or_initialize_by(provider: provider, uid: uid) do |user|
      user.name = user_name
      user.email = email
      user.password = password
      user.image_url = image_url
      user.activated = true
    end
  end

  private

    # メールアドレスをすべて小文字にする
    def downcase_email
      email.downcase!
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end