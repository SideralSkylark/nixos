{
  description = "NixOS & Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
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
        {
          hostPath,
          hmModules ? [ ],
        }:
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
                    imports = [ ./home/skylark.nix ] ++ hmModules;
                  };

                backupFileExtension = "backup";
                extraSpecialArgs = {
                  inherit nixvim;
                };
              };
            }
          ];
        };
    in
    {
      # -------- NixOS machines --------
      nixosConfigurations = {
        laptop = mkHost {
          hostPath = ./hosts/laptop/configuration.nix;
          hmModules = [
            ./home/modules/hyprland
            ./home/modules/nixvim
          ];
        };
        nixos = mkHost {
          hostPath = ./hosts/nixos/configuration.nix;
          hmModules = [
            ./home/modules/hyprland
            ./home/modules/nixvim
          ];
        };
      };

      # -------- Fedora / Standalone HM --------
      homeConfigurations = {
        skylark = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ./home/skylark.nix
            ./home/modules/standalone
            ./home/modules/nixvim
          ];
          extraSpecialArgs = {
            inherit nixvim;
          };
        };
      };
    };
}
