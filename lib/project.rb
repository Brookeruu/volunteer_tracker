class Project
  attr_reader :title,:id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    queried_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    queried_projects.each do |project|
      title = project["title"]
      id = project["id"].to_i
      projects.push(Project.new({:title => title,:id => id}))
    end
    projects
  end

  def ==(another_project)
    (self.title==another_project.title).&(self.id==another_project.id)
  end

  def self.find(id)
    Project.all().each do |project|
      if project.id().==(id)
        return project
      end
    end
    return nil
  end

  def save
    @id = DB.exec("INSERT INTO projects (title,id) VALUES ('#{@title}','#{@id}') RETURNING id;").first().fetch("id").to_i()
  end

end
