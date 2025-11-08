{
 description = "NixOs configuration";

 inputs = {
  nixpkgs.url = "nixpkgs/nixos-25.05";

  home-manager = {
   url = "github:nix-community/home-manager/release-25.05";
   inputs.nixpkgs.follows = "nixpkgs";
  };

  stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
  };

  nixvim = {
	  url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
  };
 };

 outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: {
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
   system = "x86_64-linux";

   modules = [
    ./hosts/nixos/configuration.nix
    inputs.stylix.nixosModules.stylix
    home-manager.nixosModules.home-manager {
     home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.skylark = import ./home/skylark.nix;
      backupFileExtension = "backup";
	  extraSpecialArgs = { inherit nixvim; };
     };
    }
   ];
  };
 };
}

