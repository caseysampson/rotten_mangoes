class Search < ActiveRecord::Base
  
  def movies
    @movies ||= find=movies
  end

end
