# == Schema Information
#
# Table name: blog_posts
#
#  id           :bigint           not null, primary key
#  published_at :datetime
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class BlogPost < ApplicationRecord
  # Action Text facilita la gestión de contenido enriquecido
  # en las aplicaciones Rails, proporcionando un editor de texto enriquecido 
  # y soporte para archivos adjuntos e incrustaciones multimedia. Con la configuración adecuada en el modelo, 
  # el formulario y el controlador, puedes aprovechar esta poderosa característica en tu aplicación.
  # configuración active record storage = config/storage.yml
  has_rich_text :content # action_text BlogPost.last.content.body.to_s

  validates :title, presence: true
  validates :content, presence: true

  # Los registros de BlogPost ordenados primero por la fecha de publicación (con los valores null al final) 
  # y luego por la fecha de actualización, ambos en orden descendente. Esto asegura que, entre los registros con la misma fecha de publicación, 
  # los más recientemente actualizados aparezcan primero.
  # arel_table: es una biblioteca de Ruby que se utiliza para construir consultas SQL de manera programática.
  # El uso de arel_table permite construir consultas SQL complejas de manera más legible y mantenible, aprovechando las capacidades de la biblioteca Arel para manipular y generar SQL de manera programática.
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_last).order(updated_at: :desc) } 
  scope :draft , -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= (?)", Time.current) }
  scope :scheduled, -> { where("published_at > (?)", Time.current) }

  def draft? 
    published_at.nil?
  end

  def published? 
    published_at? && published_at <= Time.zone.now
  end

  def scheduled?
    published_at? && published_at > Time.zone.now
  end
end
