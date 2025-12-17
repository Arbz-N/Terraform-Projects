#!/bin/bash
apt update
apt install -y apache2

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

cat <<EOF > /var/www/html/index.html
<h1>Terraform Web Server 2</h1>
<p>Instance ID: $INSTANCE_ID</p>
EOF

systemctl start apache2
systemctl enable apache2
