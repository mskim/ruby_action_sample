task :default => :hello

task :hello do
  puts "hello from rake task"
  content = "Wonho hello!, Created at:#{Time.now}"
  File.open("create_file.txt", 'w'){|f| f.write content}
end