#!/bin/bash

# -----------------------------
# 🛠️ 1. System Preparation
# -----------------------------
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y unzip wget curl gnupg2 software-properties-common lsb-release

# -----------------------------
# ☕ 2. Install OpenJDK 17 (Required for SonarQube 9+)
# -----------------------------
sudo apt install -y openjdk-17-jdk
java -version

# -----------------------------
# 🐘 3. Install PostgreSQL
# -----------------------------
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql

# -----------------------------
# 🧾 4. Create PostgreSQL User and DB for SonarQube
# -----------------------------
sudo -u postgres psql -c "CREATE USER sonar WITH PASSWORD 'StrongSonarPassword';"
sudo -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"
sudo -u postgres psql -c "ALTER USER sonar WITH SUPERUSER;"

# -----------------------------
# 📦 5. Download and Install SonarQube
# -----------------------------
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.3.0.82913.zip
sudo unzip sonarqube-10.3.0.82913.zip
sudo mv sonarqube-10.3.0.82913 sonarqube
sudo chown -R $USER:$USER sonarqube

# -----------------------------
# ⚙️ 6. Configure SonarQube Database Settings
# -----------------------------
sudo sed -i 's/^#sonar.jdbc.username=.*/sonar.jdbc.username=sonar/' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's/^#sonar.jdbc.password=.*/sonar.jdbc.password=StrongSonarPassword/' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's|^#sonar.jdbc.url=.*|sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube|' /opt/sonarqube/conf/sonar.properties

# -----------------------------
# 🚀 7. Start SonarQube
# -----------------------------
cd /opt/sonarqube/bin/linux-x86-64/
./sonar.sh start

# -----------------------------
# ✅ 8. Access SonarQube Web UI
# -----------------------------
echo "🌐 SonarQube is running on: http://$(curl -s ifconfig.me):9000"
echo "🔐 Login with: admin / admin"

