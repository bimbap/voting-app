# Master

#!/bin/bash
sudo yum install docker dotnet-sdk-6.0 -y
sudo usermod -aG docker ec2-user
sudo systemctl start docker
sudo systemctl enable docker

sudo -u ec2-user -i <<'EOF'
docker swarm init
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.325.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.325.0/actions-runner-linux-x64-2.325.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.325.0.tar.gz
./config.sh --url https://github.com/bimbap/voting-app --token ANT6DGICVKSBY3DXMV5LTQ3IKZQWA --name voting-app --runnergroup default --labels voting-app --work _work
sudo ./svc.sh install
sudo ./svc.sh start
EOF


# Node 1

#!/bin/bash
sudo yum install docker dotnet-sdk-6.0 -y
sudo usermod -aG docker ec2-user
sudo systemctl start docker
sudo systemctl enable docker

sudo -u ec2-user -i <<'EOF'
docker swarm join --token SWMTKN-1-31lnv4841r3xr1glofk41ynhstdyn6e5tctwfktn8mubdesuzj-9dxm1yl7bagtk9icwdnjbwszn 192.168.10.8:2377
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.325.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.325.0/actions-runner-linux-x64-2.325.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.325.0.tar.gz
./config.sh --url https://github.com/bimbap/voting-app --token ANT6DGICVKSBY3DXMV5LTQ3IKZQWA --name node-voting-app-1 --runnergroup default --labels node-voting-app-1 --work _work
sudo ./svc.sh install
sudo ./svc.sh start
EOF

# Node

#!/bin/bash
sudo yum install docker dotnet-sdk-6.0 -y
sudo usermod -aG docker ec2-user
sudo systemctl start docker
sudo systemctl enable docker

sudo -u ec2-user -i <<'EOF'
docker swarm join --token SWMTKN-1-31lnv4841r3xr1glofk41ynhstdyn6e5tctwfktn8mubdesuzj-9dxm1yl7bagtk9icwdnjbwszn 192.168.10.8:2377
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.325.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.325.0/actions-runner-linux-x64-2.325.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.325.0.tar.gz
./config.sh --url https://github.com/bimbap/voting-app --token ANT6DGICVKSBY3DXMV5LTQ3IKZQWA --name node-voting-app-2 --runnergroup default --labels node-voting-app-2 --work _work
sudo ./svc.sh install
sudo ./svc.sh start
EOF