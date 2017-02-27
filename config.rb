module Config
  @@debug = true
  def Config::debug?
    @@debug
  end

  def Config::toggle
    @@debug = !@@debug
  end
end
