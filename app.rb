require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
also_reload('lib/**/*.rb')
require("pg")
require('pry')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

post('/')do
  title = params['title']
  new_project = Project.new({:title => title,:id => nil})
  new_project.save
  @projects = Project.all()
  erb(:index)
end

get('/project/:id')do
  @project = Project.find(params.fetch("id").to_i)
  @volunteers = @project.volunteers
  erb(:project)
end

get('/edit_project/:id')do
  @project = Project.find(params.fetch("id").to_i)
  erb(:edit_project)
end

post('/edit_project/:id')do
  title = params['title']
  proj = Project.find(params.fetch("id").to_i)
  proj.update({:title => title})
  @project = Project.find(params.fetch("id").to_i)
  erb(:edit_project)
end

# get('/city_list') do
#   @cities = City.all()
#   erb(:city_list)
# end
#
# get('/train_list') do
#   @trains = Train.all()
#   erb(:train_list)
# end
#
# get('/city/:id') do
#   @city = City.find(params.fetch("id").to_i)
#   @cities = Stop.findAllCities(params.fetch("id").to_i)
#   erb(:city)
# end
#
# post('/city/:id')do
#   train = params['train']
#   time = params['time'] + ':00'
#   @cities = Stop.findAllCities(params.fetch("id").to_i)
#   @city = City.find(params.fetch("id").to_i)
#   city = @city.name
#   Train.populateTrain(train)
#   stop = Stop.populateStop(city,train,time)
#   @cities = Stop.findAllCities(params.fetch("id").to_i)
#   erb(:city)
# end
#
# get('/train/:id') do
#   @train = Train.find(params.fetch("id").to_i)
#   @trains = Stop.findAllTrains(params.fetch("id").to_i)
#   erb(:train)
# end
#
# post('/train/:id')do
#   city = params['city']
#   time = params['time'] + ':00'
#   @trains = Stop.findAllTrains(params.fetch("id").to_i)
#   @train = Train.find(params.fetch("id").to_i)
#   train = @train.name
#   City.populateCity(city)
#   stop = Stop.populateStop(city,train,time)
#   @trains = Stop.findAllTrains(params.fetch("id").to_i)
#   erb(:train)
# end
#
# get('/stops/:id')do
#   @stop = Stop.find(params.fetch("id").to_i)
#   erb(:stops)
# end
