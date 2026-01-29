{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    stylix.url = "github:nix-community/stylix";
    nvf.url = "github:notashelf/nvf";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
	nvf,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	  specialArgs = { inherit nvf; };
      modules = [
        stylix.nixosModules.stylix
        nvf.nixosModules.default
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
