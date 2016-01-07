class Logacesso
  include Mongoid::Document

  field :guid, type: String
  field :local, type: String
  field :datahora, type: DateTime
  
  def self.listar_ultimos_acessos(totalRegistros)
	Logacesso.desc(:datahora).limit(totalRegistros)
  end
end

