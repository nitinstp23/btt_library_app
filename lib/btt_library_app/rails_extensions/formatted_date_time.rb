class DateTime
  def to_date_short
    self.strftime("%d/%m/%Y")
  end
end

class Time
  def to_date_short
    self.strftime("%d/%m/%Y".freeze)
  end
end
