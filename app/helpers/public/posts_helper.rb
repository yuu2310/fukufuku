module Public::PostsHelper

  def render_with_hashtags(comment)
    comment.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, " /posts/hashtags/#{word.delete("#")}"}.html_safe
  end

end
