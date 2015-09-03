#
rm -rf ssh centos7/ssh centos6/ssh ubuntu/ssh
mkdir ssh
ssh-keygen -f ssh/id_rsa -N ''
cp -r ssh docker/centos7
cp -r ssh docker/centos6
cp -r ssh docker/ubuntu
