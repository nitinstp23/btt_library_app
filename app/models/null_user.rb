class NullUser

  def id; end

  def present?
    false
  end

  def authenticate(*)
    false
  end

end
