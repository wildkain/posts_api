class ReportDistributorMailer < ApplicationMailer

  def stat_report(email, report)
    @report = report
    mail to: email, subject: "Report"
  end
end
