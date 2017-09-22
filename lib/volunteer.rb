class Volunteer
  attr_reader :name,:project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
  end

  def self.all
    queried_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    queried_volunteers.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      volunteers.push(Volunteer.new({:name => name,:project_id => project_id}))
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



end
