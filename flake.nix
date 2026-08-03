{
  description = "NixOS & Home Manager configuration";
  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      nixvim,
      noctalia,
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
          specialArgs = { inherit inputs; };
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
                  inherit nixvim noctalia;
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
            ./home/modules/noctalia/default.nix
            ./home/modules/nixvim
          ];
        };
        nixos = mkHost {
          hostPath = ./hosts/nixos/configuration.nix;
          hmModules = [
            ./home/modules/noctalia/default.nix
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
            ./home/modules/noctalia
            ./home/modules/nixvim
          ];
          extraSpecialArgs = {
            inherit nixvim;
          };
        };
      };
    };
}
