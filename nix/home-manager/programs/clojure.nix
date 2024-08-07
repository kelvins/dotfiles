{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (clojure.override { jdk = jdk17; })
    (leiningen.override { jdk = jdk17; })
    clojure-lsp
    clj-kondo
  ];
}
