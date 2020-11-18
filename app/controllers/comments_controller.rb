class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show" 
    end
  end

  #ストロングパラメーターを用いて保存できるカラムを指定
  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    #渡されたparamsの中にcommentというハッシュがある二重構造になっているため、requireメソッドの引数に指定して、textを取り出しました。
    #user_idカラムには、ログインしているユーザーのidとなるcurrent_user.idを保存し、
    #prototype_idカラムは、paramsで渡されるようにするので、params[:prototype_id]として保存しています。
  end

end
