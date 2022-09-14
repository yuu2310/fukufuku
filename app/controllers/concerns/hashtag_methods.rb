module HashtagMethods
    extend ActiveSupport::Concern

    #--------------ハッシュタグ抽出処理　create update アクションの中で実行　----------------
    def extract_hashtag(caption)
      # 引数(caption)に入ってきた文字列から、先頭が#で始まる文字列を配列にして返すメソッド
        if caption.blank? #例外処理のため。引数が空で渡ってきた場合は処理をしない
            return
        end
        # 入力された文字列の中より、＃で始まる文字列を配列にして返す
        return caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) #=> ["#aaa","#bbb"]

    end

    #--------------ハッシュタグ保存処理　create update アクションの中で実行　----------------
    def save_hashtag(hashtag_array,post_instance)
        #hashtag_array → ["#aaa","#bbb"]
      # ハッシュタグをハッシュタグテーブルに保存する、そして中間テーブルへの保存処理を行っております。
      # 引数で渡ってきたハッシュタグの配列を、重複しないようにハッシュタグテーブルに保存の後、
      # 引数で渡ってきたpost_instance(Post.new)のようなオブジェクトのidをハッシュタグのidとセットにして中間テーブルに保存します。

        if hashtag_array.blank? #ハッシュタグを付けずに投稿された時、下のメソッドを実行させないようにする。
            return
        end

        hashtag_array.uniq.map do |hashtag|
            # ハッシュタグは先頭の#を外し、小文字にして保存
            tag = HashTag.find_or_create_by(name: hashtag.downcase.delete('#'))

            #-------中間テーブルへの保存処理--------
            post_hashtag = PostHashTag.new #中間テーブルのインスタンスを作成
            post_hashtag.post_header_id = post_instance.id
            post_hashtag.hash_tag_id = tag.id
            post_hashtag.save!
        end
    end

    #---------ハッシュタグの情報をPostオブジェクトに含めるメソッド------------
    def creating_structures(posts: "",post_hashtags: "",hashtags: "")
        #引数として必要なのはPostのデータ、中間テーブルの全データ、ハッシュタグの全てのデータです。
        #このメソッドはPostのActiveRecordインスタンスをハッシュに変換し、更に一つ一つのオブジェクト(ハッシュ形式)に対し、idに紐づくハッシュタグを配列として格納するメソッドです。
        array = [] #最終戻り値用
        posts.each do |post|
            hashtag = [] #中間テーブルのID情報から探したハッシュタグを格納するための配列
            post_hash = post.attributes #ActiveRecordインスタンスをハッシュに変換 { user_id => val, comment=> val }
            related_hashtag_records = post_hashtags.select{|ph| ph.post_header_id == post.id } #中間テーブルより投稿idが一致するレコードを取り出す

            related_hashtag_records.each do |record|
                hashtag << hashtags.detect{ |hashtag| hashtag.id == record.hash_tag_id } #上記レコードをもとにハッシュタグを検索し、配列に格納
            end
            post_hash["hashtags"] = hashtag #投稿一つ一つのデータに['hashtags']のkeyを追加、そこにハッシュタグのデータを格納する
            array << post_hash #=> [{"id"=>1, "title"=>"aaaa", "caption"=>"#aaaa", "created_at"=>Sun, 02 May 2021 15:13:42 UTC +00:00, "updated_at"=>Sun, 02 May 2021 15:13:42 UTC +00:00, "user_id"=>1, "image_id"=>"e347a197a5c2e6466db2d5b1673792c0a7b3a37460b1dea00f36b8b366a6", "hashtag"=>[#<Hashtag id: 1, name: "aaaa", created_at: "2021-05-02 15:13:42", updated_at: "2021-05-02 15:13:42">}]
        end
        return array
    end

    #---------ハッシュタグの情報をハッシュタグテーブルと中間テーブルから削除するメソッド------------
    def delete_records_related_to_hashtag(post_id)
        relationship_records = PostHashTag.where(post_header_id: post_id) #中間テーブルのレコード
        if relationship_records.present? #中間テーブルにレコードが保存されていれば
            relationship_records.each do |record|
                record.destroy #中間テーブルのレコードを削除する
            end
        end
        all_hashtags = HashTag.all
        all_related_records = PostHashTag.all
        all_hashtags.each do |hashtag|
            #ハッシュタグに紐づくレコードが中間テーブルに保存されていなければ、ハッシュタグを削除する
            if all_related_records.none?{ |record| hashtag.id == record.hash_tag_id }
                    hashtag.destroy
            end
        end
    end
end