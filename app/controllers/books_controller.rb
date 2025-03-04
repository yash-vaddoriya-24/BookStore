require "prawn"

class BooksController < ApplicationController
    before_action :authenticate_user!  # Ensure user is authenticated first
    before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy] # Apply only for actions that require admin access

    before_action :bookAll, only: [:index, :show]
    before_action :set_book, only: [:show, :edit, :update, :destroy, :preview]
    # before_action :set_user

    def show
      authorize @book
      puts "In Show"

      respond_to do |format|
        format.html
        format.pdf { send_data generate_pdf(@book) }
      end
    end

    def index
      puts "In Book controller index with user : #{current_user.email}"

      # ✅ Ensure only permitted search & sort parameters are passed
      search_params = params.fetch(:q, {}).permit(:title_or_author_cont, :s)

      @q = Book.ransack(search_params)
      @books = @q.result.order(params[:s]).page(params[:page]).per(5)

      respond_to do |format|
        format.html
        format.csv { send_data Book.to_csv(@books), filename: "books-page-#{params[:page]}-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv" }
      end

      # respond_to do |format|
      #   format.html
      #   format.turbo_stream { render partial: "books/list", locals: { books: @books } }
      # end
    end

    def preview
      # render partial: 'preview', locals: { book: @book }
    end
    def new
      @book = Book.new
      @categories = Category.all  # Get all categories for dropdown
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.append("books", partial: "book_row", locals: { book: @book })
          end
          format.html { redirect_to books_path }
        end
      else
        render :new
      end
    end

    def edit
      @categories = Category.all
      authorize @book
      # respond_to do |format|
      #   format.html # edit.html.erb (default)
      #   format.turbo_stream
      # end
    end

    def update
      authorize @book
      if @book.update(book_params)
        redirect_to root_path
      else
        render :edit, status: :unprocessable_entity
      end
    end
    def destroy
      authorize @book
      puts "In destroy"
      @book.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(@book)
        end
        format.html { redirect_to books_path }
      end
    end

    def download_pdf
      book = Book.find(params[:id])
      send_data generate_pdf(book),
                filename: "#{book.title}.pdf",
                type: "application/pdf"
    end


    private

    def book_params
      params.require(:book).permit(:title, :author, :category_id, :isbn, :price, :stock, :description, :image)
    end

    def set_book
      @book = Book.find(params[:id])
    end

    def bookAll
      @books = Book.all
    end

    # def set_user
    #   @user = User.find(params[:user_id])
    # end

    def generate_pdf(book)
      Prawn::Document.new do
        text book.title, align: :center
        text "author: #{book.author}"
        text "ISBN: #{book.isbn}"
        text "Price: #{book.price}"
      end.render
    end

    def authorize_admin
      Rails.logger.info "Authorize Admin Check - Current User: #{current_user&.email} - Admin? #{current_user&.has_role?(:admin)}"

      return redirect_to new_user_session_path, alert: "You need to sign in first." unless user_signed_in?

      unless current_user.has_role?(:admin)
        flash[:alert] = "You are not authorized to view this page."
        redirect_to root_path and return
      end
    end

end
