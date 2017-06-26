module API
  class AuthorsController < ApplicationController
    before_action :set_author, only: [:show, :edit, :update, :destroy]

    # GET /authors
    # GET /authors.json
    def index
      authors = Author.all
      render json: authors
    end

    # GET /authors/1
    # GET /authors/1.json
    def show
      render json: @author
    end



    # POST /authors
    # POST /authors.json
    def create
      author = Author.new(author_params)
      author.book_ids = params[:author][:book_ids]
      if author.save
        render json: author, status: :created, location: author
      else
        render json: author.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /authors/1
    # PATCH/PUT /authors/1.json
    def update
      if @author.update(author_params)
        @author.book_ids = params[:author][:book_ids]
        render json: @author
      else
        render json: @author.errors, status: :unprocessable_entity
      end
    end

    # DELETE /authors/1
    # DELETE /authors/1.json
    def destroy
      @author.destroy
      respond_to do |format|
        format.json { head :no_content, status: 200 }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_author
        @author = Author.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def author_params
        params.require(:author).permit(:name, book_ids: [])
      end
  end
end