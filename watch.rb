require 'fileutils'
trgFilename = "foo.txt"
backupFolder = "backups"

startSize = File.size(trgFilename)

asrcFile = File.realpath(trgFilename)
puts "Monitoring file"
puts asrcFile
ext = File.extname(asrcFile) 
puts ext

abf = File.realpath("backups")
puts "Backup directory is "
puts abf

raise "Backup directory is not a directory!" if not File.directory?(abf)

def backIt(src, bdir)
  src = File.realpath(src)
  ext = File.extname(src) 
  srcBasename = File.basename(src)
  time = Time.now.to_i
  bckFn = File.join(bdir,"#{srcBasename}_#{time}#{ext}")
  puts "copying #{src} to #{bckFn}"
  puts bckFn
  FileUtils.cp(src, bckFn)
end

backIt( asrcFile, abf )

while true
    newSize = File.size(trgFilename)
    if newSize != startSize
      startSize=newSize
      puts "File contents changed."
      backIt( asrcFile, abf )
    else
      puts newSize
    end
    sleep 1
end

