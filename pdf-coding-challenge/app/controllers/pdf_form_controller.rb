# pdfFormController class for accepting parameters from the user and filling the input PDF.
# The input PDF is located at PDF_PATH and the generated PDF is placed in OUTPUT_PDF.
# The pdf-forms gem is used to perform PDF interactions.
class PdfFormController < ApplicationController
  PDF_PATH = "#{Rails.root}/public/application.pdf"
  OUTPUT_PATH = "#{Rails.root}/public/completed_application.pdf"

  attr_reader :attributes

  def attributes
    @attributes ||= {}
  end

  def pdftk
    @pdftk ||= PdfForms.new
  end

  #Fill the input PDF based on the attributes variable and generate output PDF
  def export
    pdftk.fill_form PdfFormController::PDF_PATH, PdfFormController::OUTPUT_PATH, attributes
  end

  #fill attributes variable based on params from user. Call PDF filling function.
  def fill
    @attributes = params[:pdf_form]
    export
  end

  #Called once user submits form on webpage
  # Calls function to copy users inputs and generate output PDF
  # Show PDF inline for user to review and download
  def submit
    fill
    send_file(PdfFormController::OUTPUT_PATH, :disposition => 'inline', :type => "application/pdf")
  end

  def form
  end

  def form_params
    params.require(:pdf_form).permit(:'NAME (FIRST, MIDDLE, LAST)', :'OTHER_NAMES_MAIDEN_NICKNAMES_ETC', +
                                     :'SSN', :'HOME_ADDRESS_OR_DIRECTIONS_TOYOUR_HOME', :'APARTMENT', :'CITY', +
                                     :'COUNTY', :'STATE', :'ZIP_CODE', :'HOME_PHONE', :'EMAIL_ADDRESS')
  end

end
