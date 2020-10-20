require 'pdf_split'
require 'pry'


task :default => :hello

task :hello do
  puts "hello from rake task"
  content = "Wonho hello!, Created at:#{Time.now}"
  project_path = File.expand_path "."
  @pdf = PdfSplit::PdfSplit.new(project_path)
end