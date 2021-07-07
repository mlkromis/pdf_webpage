class ApplicationController < ActionController::Base
  def show
    user = User.find(params[:id])
    respond_to do |format|
      format.pdf { send_file TestPdfForm.new(user).export, type: 'application/pdf' }
    end
  end
end