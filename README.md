# vagrant_docker_sshd

## Install gems
```
bundle install --path vendor/bundle
```

## Generate a ssh key
```
rm -rf ssh centos7/ssh centos6/ssh ubuntu/ssh
mkdir ssh
ssh-keygen -f ssh/id_rsa -N ''
cp -r ssh docker/centos7
cp -r ssh docker/centos6
cp -r ssh docker/ubuntu
```

## vagrant up
```
vagrant up --provider=docker
```

## exec capistrano task

```
cd cap-tasks
bundle exec cap production uptime
```

## vagrant halt

```
vagrant halt
```

## vagrant up again

```
vagrant up
```

## vagrant destroy

```
vagrant destroy -f
```
