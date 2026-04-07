{
  description = "NixOS & Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      mkHost =
        hostPath:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            hostPath
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.skylark =
                  { ... }:
                  {
                    imports = [
                      ./home/skylark.nix
                      ./home/modules/hyprland
                    ];
                  };

                backupFileExtension = "backup";
                extraSpecialArgs = { inherit nixvim; };
              };
            }
          ];
        };
    in
    {
      # -------- NixOS machines --------
      nixosConfigurations = {
        laptop = mkHost ./hosts/laptop/configuration.nix;
        nixos = mkHost ./hosts/nixos/configuration.nix;
      };

      # -------- Fedora / Standalone HM --------
      homeConfigurations = {
        skylark = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home/skylark.nix
            ./home/modules/standalone
          ];
          extraSpecialArgs = { inherit nixvim; };
        };
      };
    };
}
