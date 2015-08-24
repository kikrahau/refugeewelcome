class String
  def is_numeric? 
    self.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
end