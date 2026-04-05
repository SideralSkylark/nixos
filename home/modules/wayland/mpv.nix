{
programs.mpv = {
  enable = true;
  config = {
    # Hardware decoding disabled — avoids color space and decoding bugs
    # on certain GPU drivers; software decoding is more predictable
    hwdec = "no";

    # Disable dynamic HDR peak detection — prevents mpv (gpu-next) from
    # misreading broken HDR metadata in SDR files (e.g. bt.2020/PQ tags
    # in an otherwise SDR bt.709 anime encode), which caused washed-out
    # colors in fullscreen
    hdr-compute-peak = "no";

    # Don't let the display's color profile hint override mpv's own
    # color management — avoids fullscreen vs windowed brightness
    # inconsistency on Wayland
    target-colorspace-hint = "no";
  };
};
}
