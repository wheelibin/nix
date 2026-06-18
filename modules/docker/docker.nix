{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    docker_29
    docker-credential-helpers
    dive
  ];

}
