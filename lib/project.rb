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
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first().fetch("id").to_i()
  end

  def volunteers()
    which_project = self.id
    volunteers = []
    Volunteer.all().each do |volunteer|
      if volunteer.project_id.==(which_project)
        volunteers.push(volunteer)
      end
    end
    return volunteers
  end

  def update(attributes)
    @title= attributes.fetch(:title)
    @id= self.id()
    DB.exec("UPDATE projects SET (title) = ('#{@title}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  end

end
