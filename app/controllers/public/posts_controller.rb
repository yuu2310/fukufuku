class Public::PostsController < ApplicationController
  include HashtagMethods

  before_action :authenticate_user!

  def new
    @post_header = PostHeader.new
    @post_header.post_details.build([{},{},{},{},{},{}])
    make_category
  end

  def create
    @post_header = PostHeader.new(post_params)
    @post_header.user_id = current_user.id
    if @post_header.save #一度投稿を保存
    #save_hashtag(hashtag,@post) #先ほど抽出したハッシュタグをハッシュタグテーブルへ、作成したpostのidとハッシュタグのidを中間テーブルへ保存
      flash[:notice] = "投稿しました"
      redirect_to  post_path(@post_header.id)
    else
      make_category
      render :new
    end
  end

  def index
    @posts = PostHeader.all.page(params[:page]).per(6)
    @hashtags = HashTag.all
    @post_hashtags = PostHashTag.all
    @post_objects = creating_structures(posts: PostHeader.all,post_hashtags: @post_hashtags,hashtags: @hashtags)
    search(params) if params[:post_header].present?
    make_category
  end

  def search(params)
    @posts = PostHeader.joins(post_details: {category: :type}).distinct
    # コメント検索
    @posts = @posts.where('comment LIKE ?', "%#{params[:post_header][:comment]}%").distinct if params[:post_header][:comment].present?
    # カテゴリー検索
    @posts = @posts.merge(PostDetail.where('category_id like ?', params[:post_header][:category][:category_id])).distinct if params[:post_header][:category][:category_id].present?
    @posts = @posts.page(params[:page]).per(6)
  end

  def hashtag
    @user = current_user
    @tag = HashTag.find_by(name: params[:name])
    @posts = @tag.post_headers.order(created_at: :desc)
  end

  def show
    @post = PostHeader.find(params[:id])
    related_records = PostHashTag.where(post_header_id: @post.id).pluck(:hash_tag_id) #=> [1,2,3] idのみを配列にして返す
    hashtags = HashTag.all
    @hashtags = hashtags.select{|hashtag| related_records.include?(hashtag.id)}
    #hashtagテーブルより中間テーブルで取得したidのハッシュタグを取得。配列に。
    @display_caption = @post.comment.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/,"")
    #実際に表示するキャプション。ハッシュタグが文字列のまま表示されてしまうので、#から始まる文字列を""に変換したものをViewにて表示
    @post_comment = PostComment.new
    @user = @post.user_id
  end

  def edit
    @post = PostHeader.find(params[:id])
    @user = @post.user
    make_category
  end

  def update
    @post = PostHeader.find(params[:id])
    delete_records_related_to_hashtag(params[:id]) #こちらのメソッドで中間テーブルとハッシュタグのレコードを削除
    ActiveRecord::Base.transaction do
      @post.update(post_params)
      hashtag = extract_hashtag(@post.comment) #投稿よりハッシュタグを取得
      save_hashtag(hashtag,@post) #ハッシュタグの保存
    end
    flash[:notice] = "投稿を更新しました"
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = PostHeader.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end


  private

  def post_params
    params.require(:post_header).permit(:comment, :user_id, :image, post_details_attributes: [:id, :post_header_id, :category_id, :size])
  end

  def make_category
    @categories = Category.all
    @tops = Category.where(type_id: 1) #whereは条件検索
    @jakets = Category.where(type_id: 2)
    @pants = Category.where(type_id: 3)
    @shoes = Category.where(type_id: 4)
    @accessories = Category.where(type_id: 5)
    @accessories_two = Category.where(type_id: 6)
    @category_list = [{title: "トップス", obj: @tops},{title: "ジャケット/アウター",obj: @jakets},
                      {title: "パンツ", obj: @pants},{title: "シューズ",obj: @shoes},{title: "アクセサリー",obj: @accessories},
                      {title: "アクセサリー2", obj: @accessories_two}]
  end
end
