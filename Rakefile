require 'pdf_split'


task :default => :hello

task :hello do
  puts "hello from rake task"
  content = "Wonho hello!, Created at:#{Time.now}"
  pdf_path = "DepotAjax.pdf"
  @pdf = PdfSplit::PdfSplit.new(@project_path)
end