require 'debugger'
require 'colorize'
# starting from code, go through each directory and for each file count number of lines
def count_number_of_lines(change_to_dir)
  Dir.chdir(change_to_dir)
  puts Dir.pwd.blue 
  content = Dir.glob("*")
  cur_dirs = []
  content.each do |file|
    file = "#{Dir.pwd}/#{file}"

    if File.directory?(file)
      cur_dirs << file
    else
      n = File.readlines(file).size
      print "#{file} "
      print " #{n} lines\n".green
    end
  end
  cur_dirs.each do |dir| 
    count_number_of_lines(dir)
  end

end


count_number_of_lines("/Users/minadoroudi/work/code/")
