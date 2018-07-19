{ config, pkgs, ... }:

{
# Define a user account. Don't forget to set a password with ‘passwd’.
	users.extraUsers.pierre = {
		createHome = true;
		shell = pkgs.zsh;
		extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
		isNormalUser = true;
		group = "users";
		home = "/home/pierre";
		uid = 1000;
	};
}
