class GoodmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.goodmark(board)
    redirect_to boards_path, success: t('.success')
  end

  def destroy
    board = current_user.goodmarks.find(params[:id]).board
    current_user.ungoodmark(board)
    redirect_to boards_path, success: t('.success'), status: :see_other
  end
end
