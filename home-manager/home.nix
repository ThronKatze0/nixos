# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    # inputs.ags.homeManagerModules.default
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "winklerv";
    homeDirectory = "/home/winklerv";
  };

  # Add stuff for your user as you see fit:
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
  programs.git = {
    enable = true;
    userName = "ThronKatze0";
    userEmail = "vincentius.winkler@gmail.com";
    extraConfig = {
      credential.helper = "store";
    };
  };
  programs.lazygit.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      alias yt="ytfzf"
      alias gurk="~/Downloads/gurk"
      alias config="cd /etc/nixos && nvim"
      alias display="geeqie"
    '';
  };
  programs.rofi = {
    enable = true;
  };
  programs.chromium = {
    enable = true;
    extensions = [
      {id = "gfbliohnnapiefjpjlpjnehglfpaknnc";} # surfingkeys
      {id = "epcnnfbjfcgphgdmggkamkmgojdagdnn";} # ublock
      {id = "cmpdlhmnmjhihmcfnigoememnffkimlk";} # catppuccin theme
      {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # stylus
    ];
  };
  # home.packages = with pkgs; [ steam ];

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "swww init"
        "systemctl --user start pipewire"
        # "ags -c /etc/nixos/home-manager/ags/bar-example/config.js"
        "swww img /etc/nixos/home-manager/wallpapers/nix-black-4k.png"
        "waybar -c /etc/nixos/home-manager/waybar/config -s /etc/nixos/home-manager/waybar/style.css"
      ];
      general = {
        gaps_in = 4.5;
        gaps_out = 4.5;
      };
      decoration = {
        rounding = 10;
        active_opacity = 0.9;
        inactive_opacity = 0.7;
        fullscreen_opacity = 1;
        drop_shadow = true;
        blur = {
          enabled = true;
        };
      };
      input = {
        kb_layout = "de";
      };
      bind = [
        "$mod, T, exec, alacritty"
        "$mod, B, exec, chromium"
        "$mod, A, exec, rofi -show run"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, M, exec, hyprctl dispatch exit"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
      misc = {
        disable_hyprland_logo = true;
      };
    };
  };
  programs.alacritty = {
    enable = true;
  };

  # programs.ags = {
  #   enable = true;
  #
  #   # additional packages to add to gjs's runtime
  #   extraPackages = with pkgs; [
  #     gtksourceview
  #     webkitgtk
  #     accountsservice
  #   ];
  # };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
