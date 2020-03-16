class Event < ApplicationRecord

  belongs_to :prefecture
    
  scope :search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:title])
      .event_style_is(search_params[:event_style])
      .event_from_date(search_params[:event_from_date])
      .event_to_date(search_params[:event_to_date])
      .prefecture_id_is(search_params[:prefecture_id])
  end
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :event_style_is, -> (event_style) { where(event_style: event_style) if event_style.present? }
  scope :event_from_date, -> (from) { where('? <= birthday', from) if from.present? }
  scope :event_to_date, -> (to) { where('birthday <= ?', to) if to.present? }
  scope :prefecture_id_is, -> (prefecture_id) { where(prefecture_id: prefecture_id) if prefecture_id.present? }
  
    # ↓上記実装前に記載していた文章
    #   scope :day_search, -> (search_date) {where("event_from_date <= search_date AND event_to_date >= search_date")}
end
