class Doctor
  attr_accessor :id, :name, :age, :specialty

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @age = attributes[:age]
    @specialty = attributes[:specialty]
  end

  # Método de Classe
  # Retorna um array com todas as instâncias do model doctor
  def self.all
    results = DB.execute('SELECT * FROM doctors;')

    doctors = []
    results.each do |result|
      doctor = Doctor.new(id: result['id'],
                          name: result['name'],
                          age: result['age'],
                          specialty: result['specialty'])

      doctors << doctor
    end

    doctors
  end

  # Método de Classe
  # Retorna um única instância do doctor pelo id
  def self.find(id)
    result = DB.execute("SELECT * FROM doctors WHERE id=?", id).first

    Doctor.new(id: result['id'],
               name: result['name'],
               age: result['age'],
               specialty: result['specialty'])
  end

  # Decide se é um update ou create
  # Se tem um @id é um record que já existe no database, portanto deve ser atualizado
  # Se o @id é nil é uma instancia que deve ter os dados inseridos no database
  def save
    @id ? update : create
  end

  # Apaga um record no database pelo @id da instância
  def destroy
    DB.execute('DELETE FROM doctors WHERE id=?', @id)
  end

  private

  # Método privado que insere os dados da instância no database, invocado pelo método save
  def create
    DB.execute('INSERT INTO doctors (name,age,specialty) VALUES (?,?,?)', @name, @age, @specialty)
    @id = DB.last_insert_row_id
  end

  # Método privado que atualiza os dados da instância no database, invocado pelo método save
  def update
    DB.execute('UPDATE doctors SET name=?, age=?, specialty=? WHERE id=?', @name, @age, @specialty, @id)
  end

end
