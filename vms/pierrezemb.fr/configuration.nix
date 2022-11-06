{ lib, config, pkgs, ... }:

let
  websites = [
    { name = "portfolio"; localPath = "/var/www"; remotePath = "https://github.com/PierreZ/portfolio.git"; remoteBranch = "master"; }
  ];

  hewAddress = "127.0.0.1:8090";

in
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

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 20d";
  };

  # force free up to 2GiB whenever there is less than 500MiB left
  nix.extraOptions = ''
    min-free = ${toString (500 * 1024 * 1024)}
    max-free = ${toString (2048 * 1024 * 1024)}
  '';

  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/UZhx9DiyKdsOvF5QwKJnq+th8lTurJVwPZZ2VyNGZwOgYorul2RNZNDeD9IzOT25TezUcbkZEFRqsuxjpEvx9dpyrhqj/waughSqeJaRcLmqs3+JqDCricyVIs0upiGSPMsSUMy/Rzxb5TCj1ZHope8WTwxkaAlNd7kZ2grJIduMnz9e4kgP11HqCTGopfeBplTcn4ovs61OiN57HiYIsvh5vXahu4HY6SsvAZ92i3FvghO0EwR7I8DXuMgyzA2mXnidzxyMJ2Bu1JPytCJeCC3O+wtWFCOgh8LmJ1eufn52OxbANsXw9jlWJwpx3zecEcUCfHb4pZrEYa4hlh2/reSYv9W1NFE46O5KfqmoGtbUYFJCKUJH83Ju05c0uWS+SU7wr/xKdwWvXhjt2ZgWIJ852k0rle8Is3WA+WV5Rx24xX/FMXpGmISLt3C2FUCUGvNnsUeVF0KvRibyi/AGiyI7up6te7NrEcL/EUd6c2wFUk+31TCtqcICf9JJEQboedgwv83rgLPBrKMfxcMPE4vvPZPV6sATelPBsgZ8p5hRqc95HGwIsS2LFppEq9Z5eDJOiXi9FgQlIow9XBWnmlZQRja8nvkuBVpRiA4Mv31VWgV4hzIOYx72WNGmTQBMY4SR9hpE2SVHD2YznXY38o6V3kpMPOwVVCeoToV6jw== contact@pierrezemb.fr" # content of authorized_keys file
  ];

  # Build list of systemd for each website
  systemd = lib.foldl'
    (acc: w: acc // {
      # Update unit 
      services."pull-${w.name}" = {
        serviceConfig.Type = "oneshot";
        serviceConfig.User = "hugo";
        path = with pkgs; [ git ];
        script = ''
          cd ${w.localPath} && git pull origin ${w.remoteBranch}
        '';
      };
      # Bootstrap unit
      services."bootstrap-${w.name}" = {
        serviceConfig.Type = "oneshot";
        path = with pkgs; [ git ];
        script = ''
          mkdir -p ${w.localPath} && git clone ${w.remotePath} -b ${w.remoteBranch} && chown -R hugo: ${w.remotePath}
        '';
        unitConfig.ConditionPathExists = "!${w.localPath}/${w.name}";
      };
      # Timer unit
      timers."pull-${w.name}" = {
        wantedBy = [ "timers.target" ];
        partOf = [ "pull-${w.name}.service" ];
        timerConfig = {
          OnCalendar = "minutely";
          Unit = "pull-${w.name}.service";
        };
      };

    })
    { }
    websites;

  virtualisation.oci-containers.containers.hew = {
    autoStart = true;
    ports = [ "${hewAddress}:8080" ];
    image = "helloexoworld/hands-on:latest";
  };

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
      virtualHosts."hew.pierrezemb.fr".extraConfig = ''
        reverse_proxy ${hewAddress}
      '';
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

            helloexo.world {
        	    file_server
             root * /var/www/helloexo
            }
      '';
    };
  };
  system.stateVersion = "22.05";
}

