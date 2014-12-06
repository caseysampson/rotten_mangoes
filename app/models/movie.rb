class Movie < ActiveRecord::Base

  has_many :reviews
  mount_uploader :poster, PosterUploader

  validates :title, presence: true

  validates :director, presence: true

  validates :runtime_in_minutes, numericality: { only_integer: true }

  validates :description, presence: true   

  validates :release_date, presence: true

  # validate :release_date_is_in_the_future

  scope :search_results, -> (params) do
    if params[:title].present? || params[:director].present?
      self.where("movies.title LIKE ? OR movies.director LIKE ?", params[:title], params[:director])
    else
     find_by_duration(params[:duration])
    end
  end

      
  # scope :find_by_director, ->(director) { where("director", director) }
  # scope :find_by_title, ->(title) { where("movies.title LIKE ?", title) }
  scope :find_by_duration, ->(duration) do
    case duration
    when '1'
      where("runtime_in_minutes < ?", 90)
    when '2'
      where("runtime_in_minutes BETWEEN ? AND ?", 90, 120)
    when '3'
      where("runtime_in_minutes > ?", 120)
    else
      where("runtime_in_minutes > ?", 0)
    end  
  end

  def review_average
    if reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size
    else
      puts "No reviews"
    end
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
