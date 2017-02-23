require 'test_helper'

class RentalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rental = rentals(:one)
  end

  test "should get index" do
    get rentals_url, as: :json
    assert_response :success
  end

  test "should create rental" do
    assert_difference('Rental.count') do
      post rentals_url, params: { rental: { bedrooms: @rental.bedrooms, city: @rental.city, description: @rental.description, image: @rental.image, owner: @rental.owner, title: @rental.title, type: @rental.type } }, as: :json
    end

    assert_response 201
  end

  test "should show rental" do
    get rental_url(@rental), as: :json
    assert_response :success
  end

  test "should update rental" do
    patch rental_url(@rental), params: { rental: { bedrooms: @rental.bedrooms, city: @rental.city, description: @rental.description, image: @rental.image, owner: @rental.owner, title: @rental.title, type: @rental.type } }, as: :json
    assert_response 200
  end

  test "should destroy rental" do
    assert_difference('Rental.count', -1) do
      delete rental_url(@rental), as: :json
    end

    assert_response 204
  end
end
