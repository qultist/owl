task default: %w[build]

desc "Build owl"
task :build do
	sh %(swift build -c release --disable-sandbox)
end

desc "Install owl in /usr/local/bin"
task :install => :build do
	cp '.build/release/owl', '/usr/local/bin/owl'
end

desc "Delete the build directory"
task :clean do
	sh %(rm -rf .build)
end
