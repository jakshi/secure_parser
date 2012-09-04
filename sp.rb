#!/usr/bin/ruby

users = ['dev','root']
keys = ['pam_unix\(sshd\:session\)\: session opened for user ', 'pam_unix\(sshd\:session\)\: session closed for user ']

keys_join = keys.product(users)

phrases = []

keys_join.each do |key|
  phrases << key.join
end

phrases.each do |phrase|
  logs = File.open(ARGV[0],"r")
  logs.grep(/#{phrase}/) {|s| puts s}
  logs.close
end

