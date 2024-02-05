# Setup

Steps to install and ensure automatic updates using systemd-sysupdate:

```
curl -L https://github.com/mback2k/sysext-htop/releases/latest/download/sysupdate-noop.conf --create-dirs -o /etc/sysupdate.d/noop.conf
curl -L https://github.com/mback2k/sysext-htop/releases/latest/download/sysupdate-htop.conf --create-dirs -o /etc/sysupdate.htop.d/htop.conf
curl -L https://github.com/mback2k/sysext-htop/releases/latest/download/systemd-htop.conf --create-dirs -o /etc/systemd/system/systemd-sysupdate.service.d/htop.conf
curl -L https://github.com/mback2k/sysext-htop/releases/latest/download/systemd-sysext.conf --create-dirs -o /etc/systemd/system/systemd-sysupdate.service.d/sysext.conf
systemctl daemon-reload
systemctl enable systemd-sysupdate.timer
systemctl start systemd-sysupdate.service
```
