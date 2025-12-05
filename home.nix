{ congig, pkgs, lib, ...}:

{
	home.username = "doppel";
        home.homeDirectory = "/home/doppel";
        home.stateVersion = "25.05";
	xdg.enable = true;
	programs.git.enable = true;	
	programs.bash = {
		enable = true;
		shellAliases = { test = "echo ca marche";};
	};

}
