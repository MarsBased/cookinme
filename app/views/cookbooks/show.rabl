object(:@cookbook)

attributes(:id, :title, :is_smart)

child(:@recipes) do
  attributes(
    :id,
    :title,
    :description,
    :main_photo_url,
    :main_photo_url_small,
    :has_any_photo,
    :difficulty,
    :time,
    :guests
  )

  child(:cookbook) { attributes(:id, :title) }
end