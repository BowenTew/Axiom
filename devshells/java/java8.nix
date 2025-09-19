{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk8
    maven
    gradle
  ];
  shellHook = ''
    echo "Java 8 devShell ready"
  '';
}
