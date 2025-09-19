{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk17
    maven
    gradle
  ];
  shellHook = ''
    echo "Java 17 devShell ready"
  '';
}
