class ReportGeneratorJob < ApplicationJob
  queue_as :default

  def perform(start_date, end_date, email)
    report_generation = ReportGenerate.call(start_date, end_date)

    if report_generation.success?
      ReportDistributorMailer.stat_report(email, report_generation.result).deliver_now
    end
  end
end
