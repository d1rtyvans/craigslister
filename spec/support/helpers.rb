module Helpers
  def absolute_path(path)
    File.expand_path(path, File.dirname(__FILE__))
  end
end
