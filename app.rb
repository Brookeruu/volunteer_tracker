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
  @volunteers = Volunteer.all()
  erb(:index)
end

get('/project/:id')do
  @project = Project.find(params.fetch("id").to_i)
  @volunteers = @project.volunteers
  erb(:project)
end

post('/project/:id')do
  name = params['name']
  @project = Project.find(params.fetch("id").to_i)
  @volunteer = Volunteer.new({:name => name,:project_id => @project.id,:id => nil})
  @volunteer.save
  @volunteers = @project.volunteers
  erb(:project)
end

get('/edit_project/:id')do
  @project = Project.find(params.fetch("id").to_i)
  erb(:edit_project)
end

patch('/edit_project/:id')do
  title = params['title']
  proj = Project.find(params.fetch("id").to_i)
  proj.update({:title => title})
  @project = Project.find(params.fetch("id").to_i)
  erb(:edit_project)
end

delete('/edit_project/:id')do
  project = Project.find(params.fetch("id").to_i)
  project.delete
  @projects = Project.all()
  erb(:index)
end

get('/volunteer/:id')do
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @project = Project.find(@volunteer.project_id)
  erb(:volunteer)
end

patch('/volunteer/:id')do
  vol_name = params['vol_name']
  vol = Volunteer.find(params.fetch("id").to_i)
  vol.update({:name => vol_name})
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end
