{ config, pkgs, lib, ...}:

{
	home.username = "doppel";
        home.homeDirectory = "/home/doppel";
        home.stateVersion = "25.05";
	xdg.enable = true;
    gtk = {
        enable = true;
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
    };
	programs.git = {
		enable = true;
		settings.user = {
            email = "doppel.pers@protonmail.com";
		    name = "doppel4life";
            };
		};	
    programs.fish.enable = true;
    programs.fish.shellAliases = {
        h = "echo hello";        
        nrs = "sudo nixos-rebuild switch --impure --flake .";
        nda = "sudo nixos-rebuild dry-activate --impure --flake .";
        nfu = "nix flake update";
        };
	programs.fish.functions = {
		fish_greeting = ""; 
		fish_prompt = {
			body = ''
				if [ "$USER" = "root" ]
					set_color red
				else
					set_color cyan
				end
				printf '%s ' $USER
				set_color normal
				printf 'in '
				set_color blue
				printf '%s ' (prompt_pwd)

				set -l git_branch (fish_git_prompt | string trim -c " ()")
    			if test -n "$git_branch"
        			set_color yellow
        			# Customize the specific indicators here:
        			set -g __fish_git_prompt_char_stagedconflicts '✖'
        			set -g __fish_git_prompt_char_dirtystate ' mod'      # 'mod' instead of '*'
        			set -g __fish_git_prompt_char_stagedstate ' staged'   # 'staged' instead of '+'
        			set -g __fish_git_prompt_char_upstream_ahead ' ahead '
        			set -g __fish_git_prompt_char_upstream_behind ' behind '
        
       				 printf '[%s] ' $git_branch
    			end
				
				set_color green
				printf '-> '
				set_color normal
            '';			
		};
	};

# importing config files
home.file.".config/hypr".source = /home/doppel/nixos-hyprland/hyprland-config/hypr;
home.file.".config/kitty".source = /home/doppel/nixos-hyprland/hyprland-config/kitty;
home.file.".config/waybar".source = /home/doppel/nixos-hyprland/hyprland-config/waybar;
home.file.".config/wofi".source = /home/doppel/nixos-hyprland/hyprland-config/wofi;
home.file.".vim".source = /home/doppel/.vim;

}
