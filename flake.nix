{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		nixos-wsl.url = "github:nix-community/NixOS-WSL";
		nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
	};
	outputs = {self, nixpkgs, nixos-wsl, ... }@inputs:
	{
		nixosConfigurations = { 
			"nixos" = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					nixos-wsl.nixosModules.wsl
					./wsl.nix
				];
			};
		};
	};
}
