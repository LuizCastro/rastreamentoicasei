class Logacesso
  include Mongoid::Document

  field :guid, type: String
  field :local, type: String
  field :datahora, type: DateTime
end

