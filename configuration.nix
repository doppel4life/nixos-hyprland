{ config, pkgs, lib,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # WIFI network configuration
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks = {
    "SFR_F6CE" = {
        psk = "1502Fevr!er2011";
        };
    };


  # Enable networking
  # networking.networkmanager.enable = false;

  # Enableling flakes
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the gdm  display manager 
  services.displayManager.gdm.enable = true;

  # Enable hyprland window manager
  programs.hyprland = {
	enable = true;
	withUWSM = true;
	xwayland.enable = true;
	};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  #set the fish shell as default for all users
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  
  #set thunar as file explorer
  programs.thunar.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.doppel = {
    isNormalUser = true;
    description = "doppel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    librewolf-unwrapped
    qbittorrent
    vlc
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim 
    wget
    kitty
    fish
    librewolf-unwrapped
    neofetch
    tree
    git
    tealdeer
    waybar
    wofi
    hyprpaper
    hyprlock
    brightnessctl
  ];


  #fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    ];

  #theme
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.polarity = "dark";
  stylix.cursor ={
     name = "Vimix-cursors ";
     package = pkgs.vimix-cursors;
     size = 14;
    };
   # List services that you want to enable:

  system.stateVersion = "25.05";

}
