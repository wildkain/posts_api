class Api::V1::ReportsController < ApiApplicationController

  def by_author
    prm = report_params

    ReportGeneratorJob.perform_later(
        prm[:start_date],
        prm[:end_date],
        prm[:email]
    )

    render json: { message: 'Report generation started' }
  end

  def report_params
    params.permit(:start_date, :end_date, :email)
  end
end