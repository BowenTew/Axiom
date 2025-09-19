{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk11
    maven
    gradle
  ];
  shellHook = ''
    echo "Java 11 devShell ready"
  '';
}
