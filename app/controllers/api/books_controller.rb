module API
  class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]

    # GET /books
    # GET /books.json
    def index
      books = Book.all
      render json: books
    end

    # GET /books/1
    # GET /books/1.json
    def show
      render json: @book
    end

    # POST /books
    # POST /books.json
    def create
      book = Book.new(book_params)
      if book.save
        book.author_ids = params[:author_ids]
        render json: book, status: :created, location: book
      else
        render json: book.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /books/1
    # PATCH/PUT /books/1.json
    def update
      respond_to do |format|
        if @book.update(book_params)
          @book.author_ids = params[:author_ids]
          format.json { render json: @book, status: :ok}
        else
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /books/1
    # DELETE /books/1.json
    def destroy
      @book.destroy
      respond_to do |format|
        format.json { head :no_content, status: 200 }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.  
      def book_params
        # byebug
        params.require(:book).permit(:name, :description,  author_ids: [])
      end
  end
end