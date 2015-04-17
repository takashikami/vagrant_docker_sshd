#
h=$(vagrant ssh-config | grep HostName | tr -d " +HostName")
for f in $h; do
  bundle exec knife zero bootstrap $f -u root -i ../ssh/id_rsa
done

bundle exec knife node list
#bundle exec knife cookbook create httpd -o ./cookbooks/
#bundle exec berks vendor cookbooks

bundle exec knife node run_list add db1 role[ruby]
bundle exec knife node run_list add web1 httpd
bundle exec knife node run_list add web2 httpd

bundle exec knife zero chef_client 'name:db1' --attribute ipaddress -i ../ssh/id_rsa
bundle exec knife zero chef_client 'name:web1' --attribute ipaddress -i ../ssh/id_rsa
bundle exec knife zero chef_client 'name:web2' --attribute ipaddress -i ../ssh/id_rsa
