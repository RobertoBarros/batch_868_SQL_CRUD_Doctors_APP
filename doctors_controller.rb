class DoctorsController
  def initialize
    @view = DoctorsView.new
  end

  def list
    # 1. Pegar todos os doctors
    doctors = Doctor.all

    # 2.Mandar para view exibir os doctors
    @view.list(doctors)
  end


  def create
    # Perguntar name, age, specialty
    name = @view.ask_name
    age =@view.ask_age
    specialty = @view.ask_specialty

    # Criar uma instância de doctor
    doctor = Doctor.new(name: name, age: age, specialty: specialty)

    # Salvar a instância
    doctor.save

    @view.info_created(doctor)
  end

  def update
    list
    id = @view.ask_id('update')

    doctor = Doctor.find(id)

    # Perguntar name, age, specialty
    doctor.name = @view.ask_name(doctor.name)
    doctor.age =@view.ask_age(doctor.age)
    doctor.specialty = @view.ask_specialty(doctor.specialty)

    doctor.save

  end

  def destroy
    list
    id = @view.ask_id('remove')

    doctor = Doctor.find(id)

    doctor.destroy

  end

end
