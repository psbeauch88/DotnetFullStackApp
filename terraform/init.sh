#!/bin/bash
sudo apt update -y
sudo apt install -y wget curl unzip gnupg nginx postgresql-client

# Install .NET
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update -y
sudo apt install -y dotnet-sdk-8.0

# Clone your app (change this to your GitHub repo!)
cd /home/ubuntu
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git

# Publish API and run
cd YOUR_REPO/Api
dotnet publish -c Release -o out
cd out
nohup dotnet Api.dll &

# (Optional) Publish WebApp frontend
cd ../../WebApp
dotnet publish -c Release -o out
cd out
nohup dotnet WebApp.dll &
