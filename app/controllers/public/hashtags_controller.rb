class HashtagsController < ApplicationController
  include HashtagMethods

  def index
    hashtags = HashTag.all.select(:id,:name) #全てのハッシュタグを取得
    hashtag_count = PostHashTag.all.group(:hash_tag_id).count #中間テーブルのレコードをhashtag_id毎にグループ化し、数を取得(Viewにて数を表示したいため)
    @hashtags = []
    hashtags.each_with_index do |hashtag,i| #普通にeach doでも大丈夫です。
      hashtag = hashtag.attributes #ハッシュに変換
      hashtag["count"] = hashtag_count[hashtag["id"]] #countというkeyを増やし、中間テーブルの数の情報を格納する
      @hashtags << hashtag #配列に格納
    end
    if @hashtags.length > 1
      @hashtags = @hashtags.sort{ |a,b| b["count"] <=> a["count"]} #表示はハッシュタグが使用されている投稿の多い順にする
    end
  end

  def show
    post_hashtags = PostHashTag.all
    relationship_records = post_hashtags.select{ |ph| ph.hashtag_id == params[:id].to_i}.map(&:post_header_id) #中間テーブルの全レコードより、該当ハッシュタグIDが含まれるものを取得→post_idを配列に格納 #=> [1,3]
    all_posts = Post.all
    @posts = all_posts.select{ |post| relationship_records.include?(post.id)} #中間テーブルの情報が含まれるPostのレコードを取得する
    @post_objects = creating_structures(posts: @posts,post_hashtags: post_hashtags ,hashtags: HashTag.all) #取得したレコードをハッシュに変換し、ハッシュタグを一つ一つのハッシュに格納する。
  end

end
