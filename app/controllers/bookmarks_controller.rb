class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]
  before_action :set_bookmark, only: :destroy

  # Display form to add a bookmark to a list
  def new
    @bookmark = Bookmark.new
    @movies = Movie.all # Assuming you have a Movie model
  end

  # Create a new bookmark and associate it with a list
  def create
    @bookmark = @list.bookmarks.build(bookmark_params)
    if @bookmark.save
      redirect_to @list, notice: 'Bookmark added successfully!'
    else
      render :new
    end
  end

  # Delete a bookmark from the list
  def destroy
    @bookmark.destroy
    redirect_to @bookmark.list, notice: 'Bookmark removed successfully!'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
