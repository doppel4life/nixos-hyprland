{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    stylix.url = "github:nix-community/stylix";
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }: {
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
		modules = [
                stylix.nixosModules.stylix
			     ./configuration.nix
			    home-manager.nixosModules.home-manager
			    {
                              home-manager = {
				useGlobalPkgs = true;
				useUserPackages = true;
				users.doppel = import ./home.nix;
				backupFileExtension = "backup";
			    }; 
			  }
			 ];
	};
  };
}
