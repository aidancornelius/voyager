class CertificateController < ApplicationController
  def index
    redirect_to "/profile/#{current_user.id}", notice: "You need to wait until all modules are unlocked, and you have made at least one comment before you can generate a certificate."
  end

  def pdcertificate
    # Create the PDF
  end
end
