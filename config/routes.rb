Rails.application.routes.draw do
  root 'home#index'
  get "/weekly_report", to: "home#weekly_report"
  get "/graph", to: "home#show_graph"
end
