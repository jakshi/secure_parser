#!/usr/bin/ruby

users = ['dev','root']
keys = ['pam_unix\(sshd\:session\)\: session opened for user ', 'pam_unix\(sshd\:session\)\: session closed for user ']

keys_join = keys.product(users)

phrases = []
results = []

keys_join.each do |key|
  phrases << key.join
end

phrases.each do |phrase|
  logs = File.open(ARGV[0],"r")
  logs.grep(/#{phrase}/) {|s| results << s}
  logs.close
end

result2 = []

results.each do |line|
  log_line = {}
  /(?<ldate>.*)\ phx\-demo\ sshd\[(?<lproc>\d+)\].*session\ (?<lstate>[closedpen]+)\ for\ user\ (?<luser>\w+)/ =~ line
  log_line[:date] = ldate
  log_line[:proc] = lproc
  log_line[:state] = lstate
  log_line[:user] = luser
  result2 << log_line
#  puts "date - #{log_line[:date]}, proc - #{log_line[:proc]}, state - #{log_line[:state]}, user - #{log_line[:user]}"
end

sorted = result2.sort_by {|line| line[:proc]}
sorted.each { |res| p res }
