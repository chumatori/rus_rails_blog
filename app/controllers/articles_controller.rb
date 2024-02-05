class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'secret', password: 'secret', except: [:index, :show]
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find params[:id]
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permit_params)
    @article.save ? redirect_to(@article) : render(:new, status: :unprocessable_entity)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find params[:id]
    @article.update(permit_params)
    @article.save ? redirect_to(@article) : render(:edit, status: :unprocessable_entity)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private

  def permit_params
    params.require(:article).permit(:title, :body, :status)
  end

end
