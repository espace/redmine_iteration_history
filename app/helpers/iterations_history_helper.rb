module IterationsHistoryHelper
  def due_date_distance_in_words(from_date,to_date)
      l((from_date < to_date ? :label_due_delayed : :label_earlier_due), distance_of_date_in_words(from_date, to_date))
  end
end