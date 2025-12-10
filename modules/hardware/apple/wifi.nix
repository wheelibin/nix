{ pkgs, ... }:

{
  boot.extraModprobeConfig = ''
    # Work around Broadcom suspend/resume issues
    options brcmfmac roamoff=1
  '';

  systemd.services.fix-wifi-resume = {
    description = "Reload WiFi module after resume";
    after = [
      "network.target"
      "sleep.target"
    ];
    wantedBy = [ "sleep.target" ];

    serviceConfig.Type = "simple";
    serviceConfig.ExecStart = "${pkgs.kmod}/bin/modprobe -r brcmfmac";
    serviceConfig.ExecStartPost = "${pkgs.kmod}/bin/modprobe brcmfmac";
  };
}
