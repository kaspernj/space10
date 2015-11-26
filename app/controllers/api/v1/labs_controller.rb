class Api::V1::LabsController < Api::V1::ApiController
  before_filter :authenticate_api_client, only: [:index, :show]

  def index
    @labs = Lab.published.paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
  end

  def show
    @lab = Lab.published.find(params[:id])
    respond_to do |format|
      format.html { render 'labs/show' }
      format.json { @lab }
    end
  end
end