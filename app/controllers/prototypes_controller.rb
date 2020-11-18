class PrototypesController < ApplicationController

  before_action :set_prototype, only: [:edit, :show, :update]
  before_action :authenticate_user!,only: :new
  before_action :move_to_index, only: :edit


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
  
    if @prototype.save
      # 成功した場合はredirect_toメソッドでルートパスにリダイレクト
      redirect_to root_path
    else
      # 失敗した場合はrenderメソッドでprototypes/new.html.erbのページを表示
      render :new
    end
  end

  def show
    # @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # @prototype = Prototype.find(params[:id])
  end

  def update
    # @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      # 成功した場合はredirect_toメソッドでルートパスにリダイレクト
      redirect_to root_path
    else
      # 失敗した場合はrenderメソッドでprototypes/new.html.erbのページを表示
      render :edit
    end
  end



  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    # 配列として受け取ったデータを含むストロングパラメーターを定義
                  # 配列に対して保存を許可したい場合は、キーに対し[]を値として記述# 
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  
  def move_to_index
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
    # redirect_to action: :リダイレクト先となるアクション名
    # unless 条件式
    # 条件式がfalseのときに実行する処理
    # end 

    # unlessでuser_signed_in?を判定して、その返り値がfalseだった場合にredirect_toが実行
end
