{ ... }:

(final: prev: {
  rtk =
    let
      version = "1.0.1";

      assets = {
        x86_64-linux = {
          name = "rtk-x86_64-unknown-linux-musl.tar.gz";
          hash = "sha256-W5GcO8y3mbZ6YYZtDmF0EKT83xc+JhREDlneL6IANDY=";
        };
        aarch64-linux = {
          name = "rtk-aarch64-unknown-linux-gnu.tar.gz";
          hash = "sha256-zWJ8QJGtkLXlrKg8pa9m7kuKqFN6c2Uz+pBUT0YfHCs=";
        };
      };

      asset =
        assets.${prev.stdenv.hostPlatform.system}
          or (throw "rtk: unsupported platform ${prev.stdenv.hostPlatform.system}");
    in
    prev.stdenvNoCC.mkDerivation {
      pname = "rtk";
      inherit version;

      src = prev.fetchurl {
        url = "https://github.com/rtk-ai/rtk/releases/download/v${version}/${asset.name}";
        inherit (asset) hash;
      };

      dontUnpack = true;

      nativeBuildInputs = prev.lib.optionals prev.stdenv.hostPlatform.isLinux [
        prev.autoPatchelfHook
      ];
      buildInputs = prev.lib.optionals prev.stdenv.hostPlatform.isLinux [
        prev.stdenv.cc.cc.lib
      ];

      installPhase = ''
        runHook preInstall
        tar -xzf "$src"
        install -Dm755 rtk "$out/bin/rtk"
        runHook postInstall
      '';

      meta = with prev.lib; {
        description = "CLI proxy that filters and summarizes command output to reduce LLM token consumption";
        homepage = "https://github.com/rtk-ai/rtk";
        license = licenses.asl20;
        platforms = [ "x86_64-linux" "aarch64-linux" ];
        mainProgram = "rtk";
        sourceProvenance = [ sourceTypes.binaryNativeCode ];
      };
    };
})
