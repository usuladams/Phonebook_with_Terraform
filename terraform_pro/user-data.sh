#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
pip3 install flask_mysql
yum install git -y
TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxxx"
cd /home/ec2-user && git clone https://$TOKEN@github.com/usuladams/Phonebook_with_Terraform.git
python3 /home/ec2-user/Phonebook_with_Terraform/phonebook-app.py