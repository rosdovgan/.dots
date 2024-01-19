{ pkgs, ... }: {
  home.packages = with pkgs.gst_all_1; [
    gstreamer
    gst-plugins-base
    ];

  home.sessionVariables.GST_PLUGIN_SYSTEM_PATH
    = with pkgs.gst_all_1; ''${gst-plugins-base}/lib/gstreamer-1.0:'';
}
