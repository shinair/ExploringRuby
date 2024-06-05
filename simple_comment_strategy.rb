require_relative 'comment_strategy'

 # Comment strategy to determine comment bsed on health
 class SimpleCommentStrategy
    include CommentStrategy
    def update_comment(dino)
      dino['comment'] = dino['health'] > 0 ? 'Alive' : 'Dead'
    end
  end