Rails.application.routes.draw do

  #starting point of website
  root 'pdf_form#form'

  #routing to submit through post method
  post 'pdf_form/submit'

end
