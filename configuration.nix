{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10; 
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enableling flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

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

  # Enable the display manager
  #services.displayManager.gdm.enable = true;

  # Enable hyprland window manager
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Enable greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
    };
  };
  # This stops boot logs from "bleeding" into the tuigreet UI
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "null";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
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
  services.libinput.enable = true;

  #set the fish shell as default for all users
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # setting up nvf
  programs.nvf = {
    enable = true;
    # Your settings go here
    settings = {
      vim = {
        options = {
                shiftwidth = 4;
                tabstop = 4;
                autoindent = true;
                showmode = false;
                };
        viAlias = true;
        vimAlias = true;
        
        autocomplete.blink-cmp = {
            enable = true;
            setupOpts = {
                keymap.preset = "super-tab";
                completion.ghost_text.enabled = true;
                sources.default = [ "lsp" "path" "snippets" "buffer" ];
                };
            };

        statusline.lualine = {
            enable = true;
            sectionSeparator = {left ="|"; right ="|";};
            componentSeparator = {left = "|"; right = "|";};
            
            refresh = {
                statusline = 1000;
                tabline = 1000;
                winbar = 1000;
                    };

            # Defining the actual sections
            activeSection = {
                a = [ "{'mode'}" ];
                b = [ "{'branch'}" "{'diff'}" "{'diagnostics'}" ];
                c = [ "{'filename'}" ];
                x = [ "{'encoding'}" "{'fileformat'}" "{'filetype'}" ];
                y = [ "{'progress'}" ];
                z = [ "{'location'}" ];
                    };
            };
        #languages.enableTreesitter = true;

        # Enable some basic features
        lsp.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = false;

        # Language support examples
        languages = {
            #enableLSP = true;
            enableTreesitter = true;
            nix = { 
                enable = true;
                format.enable = true;
                format.type = ["nixfmt"];
                };

            python = {
                enable = true;
                lsp.enable = true;
                lsp.servers = ["pyright"];
                format.enable = true;
                dap.enable = true ;
                };
            
            typst = {
                enable = true;
                lsp.enable = true;
                lsp.servers = ["tinymist"];
                format.enable = true;
                extensions.typst-preview-nvim.enable = true;
                };
            rust.enable = true;
            markdown.enable = true;
            
        };
      };
    };
  };
  #set thunar as file explorer
  programs.thunar.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.doppel = {
    isNormalUser = true;
    description = "doppel";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      #  thunderbird
      neovim
      librewolf-unwrapped
      qbittorrent
      vlc
      inkscape
      zathura
      libreoffice
#shotwell
      loupe
      rapidraw
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
    nmgui
    htop
    bc
    typst
  ];

  #fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  #theme
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    polarity = "dark";
    cursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 14;
        };
    };
  # List services that you want to enable:

  system.stateVersion = "25.05";
}
