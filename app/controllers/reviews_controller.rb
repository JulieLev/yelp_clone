class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # @restaurant = Restaurant.find(params[:restaurant_id])
    # @restaurant.reviews.create(review_params)
    # redirect_to '/restaurants'
    puts review_params
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path,
        alert: 'You have already reviewed this restaruant'
      else
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
