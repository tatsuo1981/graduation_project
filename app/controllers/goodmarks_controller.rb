class GoodmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.goodmark(@board)
  end

  def destroy
    @board = current_user.goodmarks.find(params[:id]).board
    current_user.ungoodmark(@board)
  end
end
