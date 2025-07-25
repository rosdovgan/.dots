#!/bin/sh

if [ "$1" = "" ]; then
  echo "Specify script name"
  exit 1
fi

echo '#!/bin/sh' > "$1.sh"
chmod +x "$1.sh"
