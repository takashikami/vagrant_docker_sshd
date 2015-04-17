v_ = `vagrant ssh-config`.split(/\n\n/).map do |entry|
  entry.split("\n").map{|ele|ele.gsub(/^  /,"").split(' ')}.flatten
end.map{|entry|Hash[*entry]}
vhost = {};v_.each{|e|vhost[e['Host']]=e['HostName']}

role :demo, [vhost['web1'], vhost['web2'], vhost['db1']]

task :redhatversion do
  on roles(:demo), in: :parallel do |host|
    uptime = capture('cat /etc/redhat-release')
    puts "#{host.hostname} reports: #{uptime}"
  end
end

task :uptime do
  on roles(:demo), in: :parallel do |host|
    uptime = capture(:uptime)
    puts "#{host.hostname} reports: #{uptime}"
  end
end

set :ssh_options, {
  user: 'root',
  keys: %w(../ssh/id_rsa),
  forward_agent: false,
  auth_methods: %w(publickey)
}

set :log_level, :info
