# vagrant_docker_sshd

## Install gems
```
bundle install --path vendor/bundle
```

## Generate a ssh key
```
rm -rf ssh centos7/ssh ubuntu/ssh
mkdir ssh
ssh-keygen -f ssh/id_rsa -N ''
cp -r ssh centos7
cp -r ssh ubuntu
```

## vagrant up
```
vagrant up --provider=docker
```

## exec capistrano task

```
bundle exec cap production uptime
```
