{
	pkgs,
		inputs,
		...
}: {
	time.timeZone = "Asia/Shanghai";
	networking.hostName = "nixos";
	environment.enableAllTerminfo = true;
	security.sudo.wheelNeedsPassword = false;
	users.users.nixos = {
		isNormalUser = true;
		description = "nixos";
		extraGroups = [
			"networkmanager"
				"wheel"
		];
	};
	environment.systemPackages = with pkgs; [
		git vim curl wget
	];
	system.stateVersion = "23.11";
	wsl = {
		enable = true;
		wslConf.automount.root = "/mnt";
		wslConf.interop.appendWindowsPath = false;
		wslConf.network.generateHosts = false;
		wslConf.boot.systemd = true;
		wslConf.user.default = "nixos";
		startMenuLaunchers = true;
	};
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.gc = {
		automatic = true;
		options = "--delete-older-than 5d";
	};
	environment.variables.EDITOR = "vim";
	# 启用 OpenSSH 后台服务
	services.openssh = {
		enable = true;
		settings = {
			X11Forwarding = true;
			PermitRootLogin = "yes"; # able root login
				PasswordAuthentication = false; # disable password login
		};
		openFirewall = false;
	};
}
