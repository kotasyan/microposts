module UsersHelper
    # 与えられたuserのGravatarを返す
    def gravatar_for(user, options = { size: 80 })
        # メールアドレスをMD5ハッシュ化
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        # 画像のサイズを縦横80pxに指定
        size = options[:size]
        # gravatarの画像用のURL
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        # imageタグを生成
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end
        