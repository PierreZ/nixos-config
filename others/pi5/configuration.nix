{ config, pkgs, ... }:

{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "pi5";

  environment.systemPackages = with pkgs; [
    docker
    cockpit
    k3s
  ];

  sdImage.compressImage = false;

  services.cockpit.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;

  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/UZhx9DiyKdsOvF5QwKJnq+th8lTurJVwPZZ2VyNGZwOgYorul2RNZNDeD9IzOT25TezUcbkZEFRqsuxjpEvx9dpyrhqj/waughSqeJaRcLmqs3+JqDCricyVIs0upiGSPMsSUMy/Rzxb5TCj1ZHope8WTwxkaAlNd7kZ2grJIduMnz9e4kgP11HqCTGopfeBplTcn4ovs61OiN57HiYIsvh5vXahu4HY6SsvAZ92i3FvghO0EwR7I8DXuMgyzA2mXnidzxyMJ2Bu1JPytCJeCC3O+wtWFCOgh8LmJ1eufn52OxbANsXw9jlWJwpx3zecEcUCfHb4pZrEYa4hlh2/reSYv9W1NFE46O5KfqmoGtbUYFJCKUJH83Ju05c0uWS+SU7wr/xKdwWvXhjt2ZgWIJ852k0rle8Is3WA+WV5Rx24xX/FMXpGmISLt3C2FUCUGvNnsUeVF0KvRibyi/AGiyI7up6te7NrEcL/EUd6c2wFUk+31TCtqcICf9JJEQboedgwv83rgLPBrKMfxcMPE4vvPZPV6sATelPBsgZ8p5hRqc95HGwIsS2LFppEq9Z5eDJOiXi9FgQlIow9XBWnmlZQRja8nvkuBVpRiA4Mv31VWgV4hzIOYx72WNGmTQBMY4SR9hpE2SVHD2YznXY38o6V3kpMPOwVVCeoToV6jw== contact@pierrezemb.fr" # content of authorized_keys file
  ];

  services = {
    openssh = {
      enable = true;
      settings.X11Forwarding = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PasswordAuthentication = false;
      settings.UseDns = false;
    };
  };

  # k3s
  # https://nixos.wiki/wiki/K3s
  networking.firewall.allowedTCPPorts = [ 6443 ];
  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  ];
  boot.kernelParams = [
    "cgroup_enable=cpuset"
    "cgroup_memory=1"
    "cgroup_enable=memory"
  ];

  system.stateVersion = "23.11";
}
