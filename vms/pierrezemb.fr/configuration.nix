{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloud-init
    caddy
    docker
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;

  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/UZhx9DiyKdsOvF5QwKJnq+th8lTurJVwPZZ2VyNGZwOgYorul2RNZNDeD9IzOT25TezUcbkZEFRqsuxjpEvx9dpyrhqj/waughSqeJaRcLmqs3+JqDCricyVIs0upiGSPMsSUMy/Rzxb5TCj1ZHope8WTwxkaAlNd7kZ2grJIduMnz9e4kgP11HqCTGopfeBplTcn4ovs61OiN57HiYIsvh5vXahu4HY6SsvAZ92i3FvghO0EwR7I8DXuMgyzA2mXnidzxyMJ2Bu1JPytCJeCC3O+wtWFCOgh8LmJ1eufn52OxbANsXw9jlWJwpx3zecEcUCfHb4pZrEYa4hlh2/reSYv9W1NFE46O5KfqmoGtbUYFJCKUJH83Ju05c0uWS+SU7wr/xKdwWvXhjt2ZgWIJ852k0rle8Is3WA+WV5Rx24xX/FMXpGmISLt3C2FUCUGvNnsUeVF0KvRibyi/AGiyI7up6te7NrEcL/EUd6c2wFUk+31TCtqcICf9JJEQboedgwv83rgLPBrKMfxcMPE4vvPZPV6sATelPBsgZ8p5hRqc95HGwIsS2LFppEq9Z5eDJOiXi9FgQlIow9XBWnmlZQRja8nvkuBVpRiA4Mv31VWgV4hzIOYx72WNGmTQBMY4SR9hpE2SVHD2YznXY38o6V3kpMPOwVVCeoToV6jw== contact@pierrezemb.fr" # content of authorized_keys file
  ];

  services = {
    cloud-init = {
      enable = true;
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };

    caddy = {
      enable = false;
      acmeCA = config.security.acme.defaults.server;
      email = "contact@pierrezemb.fr";
      extraConfig = ''
            pierrezemb.fr {
             file_server
             root * /var/www/pierrezemb
              metrics /metrics
             log {
              output stdout
              format console
             }
            } 

            hew.pierrezemb.fr {
             reverse_proxy 127.0.0.1:8090
            }

            helloexo.world {
        	    file_server
             root * /var/www/helloexo
            }
      '';
    };
  };
  system.stateVersion = "22.05";
}

