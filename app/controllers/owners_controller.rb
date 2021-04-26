class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all
    # load all the pets first
    erb :'/owners/new'
  end

  post '/owners' do 
    # binding.pry
    # params = {"owner"=>{"name"=>"Adele", "pet_ids"=>["1", "2"]}}
    # mass assignment via 
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty? # if there is a value entered in create a new pet in THAT form
      @owner.pets << Pet.create(:name => params["pet"]["name"])
      # if so, it will add to that owner's pets
    end
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end 
    # removes all previous pets if owner has no pet_ids
    @owner = Owner.find(params[:id])
    # binding.pry
    # params =  "owner"=>{"name"=>"Shitty", "pet_ids"=>["3", "4"]}, "pet"=>{"name"=>"Another Fake Pet"}, "id"=>"5"}
    @owner.update(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "/owners/#{@owner.id}"
  end

end