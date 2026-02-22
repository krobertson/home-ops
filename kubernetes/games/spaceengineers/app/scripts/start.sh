#!/bin/bash

# Optional ability to download plugins, but it doesn't return a last modified header
#(
#  set +e
#  xq -x "//TorchConfig/Plugins" < torch.cfg  | xargs -I {} wget --content-disposition --timestamping "https://torchapi.com/plugin/download/{}"
#)

# Launch Space Engineers
exec xvfb-run -a wine Torch.Server.exe -autostart -nogui -console
