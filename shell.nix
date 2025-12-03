let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

let 
  mcp-server-playwright = pkgs.writeShellScriptBin "mcp-server-playwright" ''
              export PWMCP_PROFILES_DIR_FOR_TEST="$PWD/.pwmcp-profiles"
              exec ${pkgs.playwright-mcp}/bin/mcp-server-playwright "$@"
            '';
in pkgs.mkShell {
  packages = with pkgs; [
    nodejs
    mcp-server-playwright
    claude-code
    ripgrep
    gh
    chromium
    electron-chromedriver_36
    xclip
    uv
    (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.requests
        python-pkgs.selenium
        python-pkgs.beautifulsoup4
      ]))
  ];
}


