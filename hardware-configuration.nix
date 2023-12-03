# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/hardware/network/broadcom-43xx.nix")
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/c010c509-4403-4b35-a1fe-28edf8a27cb2";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-a6f0a4f7-06f4-4314-8d0f-c16fbbe5129c".device = "/dev/disk/by-uuid/a6f0a4f7-06f4-4314-8d0f-c16fbbe5129c";

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/21D5-0103";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/c4b8e89d-83ac-4687-b485-9be6f0e713d9"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
