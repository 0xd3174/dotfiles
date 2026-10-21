{ ... }:

(final: prev: {
  photocraft =
    let
      pname = "photocraft";
      version = "0.3.0";

      src = prev.fetchurl {
        url = "https://github.com/storytold/photocraft/releases/download/v${version}/photocraft-${version}-linux-x86_64.AppImage";
        hash = "sha256-KeMBH0mlLqJcj+QEJYpsX62wIJTbtAqITWnmuoCOYTY=";
      };

      appimageContents = prev.appimageTools.extract {
        inherit pname version src;
      };
    in
    prev.appimageTools.wrapType2 {
      inherit pname version src;

      extraPkgs = pkgs: with pkgs; [
        wayland
        libxkbcommon
        vulkan-loader
        libGL
      ];

      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/ai.storyteller.photocraft.desktop $out/share/applications/photocraft.desktop
        install -m 444 -D ${appimageContents}/ai.storyteller.photocraft.png $out/share/icons/hicolor/512x512/apps/photocraft.png
        substituteInPlace $out/share/applications/photocraft.desktop \
          --replace-fail 'Exec=photocraft' "Exec=$out/bin/photocraft" \
          --replace-fail 'Icon=ai.storyteller.photocraft' 'Icon=photocraft'
      '';

      meta = with prev.lib; {
        description = "An open-source, clean-room reimplementation of Adobe Photoshop in pure Rust";
        homepage = "https://github.com/storytold/photocraft";
        license = with licenses; [ mit asl20 ];
        platforms = [ "x86_64-linux" ];
        mainProgram = "photocraft";
      };
    };
})
