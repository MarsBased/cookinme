object(:@cookbook)

attributes(:id, :title, :is_smart)

child(:@recipes) do
  extends "recipes/show"
end