{ congig, pkgs, lib, ...}:

{
	home.username = "doppel";
        home.homeDirectory = "/home/doppel";
        home.stateVersion = "25.05";
	xdg.enable = true;
	programs.git = {
		enable = true;
		userEmail = "doppel.pers@protonmail.com";
		userName = "doppel4life";
		};	
    programs.fish.enable = true;
    programs.fish.shellAliases = {
        h = "echo hello";        
        nrs = "sudo nixos-rebuild switch --impure --flake .";
        nfu = "nix flake update";
        };

# importing config files
home.file.".config/hypr/".source = /home/doppel/nixos-hyprand/nixos-hyprland/hyprland-config/hypr;
home.file.".config/kitty/".source = /home/doppel/nixos-hyprand/nixos-hyprland/hyprland-config/kitty;
home.file.".config/waybar/".source = /home/doppel/nixos-hyprand/nixos-hyprland/hyprland-config/waybar;
}
