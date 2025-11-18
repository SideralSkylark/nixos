{ pkgs, ... }:

{
    services.printing = {
		enable = true;
		drivers = [
		    pkgs.hplip
			pkgs.epson-escpr
		];
	}; 
}

