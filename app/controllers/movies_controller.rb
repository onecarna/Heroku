class MoviesController < ApplicationController # defines actions in controller via methods
	before_action :load_movie, only: [:edit, :show, :update] #specifies which methods to call before others
	#only for some methods will before_action be applied i.e. before edit, show & update
	def index
		@movies = Movie.search_for(params[:q]) #:q refers to tex_field_tag in index.html
	end

  	def new
		@movie = Movie.new #will render the form for showing the movie w/o attributes
	end

	def create
		@movie = Movie.new(safe_movie_params) #create will push to database and then to show method
		if @movie.save
			redirect_to @movie #or movie_path(@movie) for redirect_to
		else
			render 'new'
		end
	end

	def edit #used to find movie in database
	end

	def update #when want to submit changes to database
		@movie.update movie_params
		redirect_to @movie #@movie will call show method
	end

	def show
	end

	private #can only be called within the controllers

	def safe_movie_params
	 	params.require('movie').permit(:title, :description, :year_released, :rating)
	 	#ensures that the fields are what we want it to be
	end

    def load_movie #displays error if unable to find movie ID e.g. 30 but only 20 available
      @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound #in the event receive record not found
      flash.now[:notice] = "Invalid Movie ID #{params[:id]}" #:id of what person trying to find
      redirect_to root_path
    end
end
