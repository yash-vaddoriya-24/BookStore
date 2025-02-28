require "prawn"

class BooksController < ApplicationController
    before_action :authenticate_user!  # Ensure user is authenticated first
    before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy] # Apply only for actions that require admin access

    before_action :bookAll, only: [:index, :show]
    before_action :set_book, only: [:show, :edit, :update, :destroy]
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
      search_params = params.fetch(:q, {}).permit(:name_or_author_cont, :s)

      @q = Book.ransack(search_params)
      @books = @q.result.order(params[:s]).page(params[:page]).per(5)

      respond_to do |format|
        format.html
        format.csv { send_data Book.to_csv(@books), filename: "books-page-#{params[:page]}-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv" }
      end
    end

    def new
      @book = Book.new # Create a new book object for the form
    end

    def create
      @book = Book.new(book_params) # Use strong parameters

      if @book.save
        redirect_to books_path, notice: "Book was successfully created." # Success message
      else
        render :new # Re-render the form if validation fails
      end
    end

    def edit
      authorize @book
    end

    def update
      authorize @book
      if @book.update(book_params)
        redirect_to books_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @book
      puts "In destroy"
      @book.destroy
      redirect_to books_path
    end

    def download_pdf
      book = Book.find(params[:id])
      send_data generate_pdf(book),
                filename: "#{book.name}.pdf",
                type: "application/pdf"
    end


    private

    def book_params
      params.require(:book).permit(:name, :author, :isbn, :price)
      # Permit only the allowed attributes
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
        text book.name, align: :center
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
