class Event < ApplicationRecord

  scope :search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name])
      .prefecture_like(search_params[:prefecture])
      .style_like(search_params[:style])
      .from_date(search_params[:from_date])
      .to_date(search_params[:from_date])

  end
  
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :style_like, -> (style) { where('style LIKE ?', "%#{style}%") if style.present? }
  scope :from_date, -> (from_date) { where('from_date <= ?', from_date) if from_date.present? }
  scope :to_date, -> (from_date) { where('to_date >= ?', from_date) if from_date.present? }
  scope :prefecture_like, -> (prefecture) { where('prefecture LIKE ?', "%#{prefecture}%") if prefecture.present? }
  
end
