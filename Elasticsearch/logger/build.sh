chmod +x gradlew
gradlew clean build

mkdir -p /opt/logger
systemctl stop logger
cp -f logger-1.0.jar  /opt/logger/logger-1.0.jar
chmod 750 /opt/logger/logger-1.0.jar
ln -sf  /opt/logger/logger-1.0.jar  /etc/init.d/logger
systemctl daemon-reload
systemctl start logger
chkconfig logger on
