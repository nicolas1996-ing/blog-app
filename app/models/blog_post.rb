class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

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
