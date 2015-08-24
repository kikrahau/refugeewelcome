class Object

  def or(_or)
    self.blank? ? _or : self
  end

  def r(what=nil)
    raise debug what if respond_to?(:debug)
    raise what.kind_of?(String) ? what : what.to_json
  end

end
