# Vagrant's "change host name" capability for Fedora
# maps hostname to loopback, conflicting with hostmanager.
# We must repair /etc/hosts
# sed doesn't work as an inline script in vagrant (???)
sudo sed -i '/127\.0\.0\.1\s.*example.*/d' /etc/hosts
