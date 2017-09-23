class Volunteer
  attr_reader :name,:project_id
  attr_accessor :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def self.all
    queried_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    queried_volunteers.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      id = volunteer["id"].to_i
      volunteers.push(Volunteer.new({:name => name,:project_id => project_id,:id => id}))
    end
    volunteers
  end

  def ==(another_volunteer)
    (self.name==another_volunteer.name).&(self.project_id==another_volunteer.project_id)
  end

  def self.find(id)
    Volunteer.all().each do |volunteer|
      if volunteer.id().==(id)
        return volunteer
      end
    end
    return nil
  end

  def save
    @id = DB.exec("INSERT INTO volunteers (name,project_id) VALUES ('#{@name}','#{@project_id}') RETURNING id;").first().fetch("id").to_i()
  end

  def self.find_by_name(name)
    Volunteer.all().each do |vol|
      if vol.name().==(name)
        return vol
      end
    end
    return nil
  end

  def update(attributes)
    @name= attributes.fetch(:name)
    @id= self.id()
    DB.exec("UPDATE volunteers SET (name) = ('#{@name}') WHERE id = #{@id};")
  end

end
