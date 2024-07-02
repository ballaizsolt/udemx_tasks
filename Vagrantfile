# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.hostname = "debian-server"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.network "private_network", type: "dhcp"
  config.vm.metwork "forwarded_port", guest: 80, host: 8080
  config.vm.metwork "forwarded_port", guest: 443, host: 8443
  config.vm.metwork "forwarded_port", guest: 22, host: 2222

  config.vm.provision "shell", inline: <<-SHELL
    # Partitioning and formatting disks
    echo -e "o\nn\np\n1\n\n+5G\nn\np\n2\n\n+2G\nw" | fdisk /dev/sda
    mkfs.ext4 /dev/sda1
    mkfs.ext4 /dev/sda2
    mkdir /opt
    mkdir /tmp
    mount /dev/sda1 /opt
    mount /dev/sda2 /tmp

    # Updating fstab
    echo '/dev/sda1 /opt ext4 defaults 0 0' >> /etc/fstab
    echo '/dev/sda2 /tmp ext4 defaults 0 0' >> /etc/fstab

    # Update and install basic packages
    apt-get update
    apt-get install -y sudo mc htop openjdk-8-jdk openjdk-11-jdk

    # Set Java 8 as the default version
    update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
    update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac

    # Create udemx user with home directory in /opt
    useradd -m -d /opt/udemx udemx
    passwd udemx
    usermod -aG sudo udemx

    # Set up SSH
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
    systemctl restart ssh

    # Install fail2ban
    apt-get install -y fail2ban
    cat <<EOF > /etc/fail2ban/jail.local
    [sshd]
    enabled = true
    port = 2222
    EOF
    systemctl restart fail2ban
  SHELL
end
