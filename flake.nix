{
	description = "My system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#nixvim = {
		#	url = "github:nix-community/nixvim/nixos-24.11";
		#	inputs.nixpkgs.follows = "nixpkgs";
		#};		
	};

	outputs = { nixpkgs, home-manager, ...}:
		let 
			system = "x86_64-linux";
		in {
			nixosConfigurations.swhit = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ ./configuration.nix ];
		};

		homeConfigurations.swhit = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [ ./home.nix ];
		};
	};
}
