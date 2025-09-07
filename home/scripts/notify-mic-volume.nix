{pkgs, ...}: {
  runtimeInputs = with pkgs; [
    coreutils
    libnotify
    wireplumber
  ];

  text = ''
    STATUS=$(wpctl status \
      | awk '/Sources:/ {inside=1; next} inside && /\*/ {print; exit}'
    )

    NAME=$(
      echo "$STATUS" \
        | sed -E 's/^.*\* *[0-9]+\. *//' \
        | sed -E 's/\[[^]]*\]$//' \
        | sed -E 's/[[:space:]]+$//')

    VOLUME=$(sed -E 's/.*\[.*vol: ([0-9]+\.[0-9]+).*\].*/\1/' <<< "$STATUS")
    VOLUME=$(awk "BEGIN {printf \"%d\", $VOLUME*100}")
    MUTED=$(sed -nE 's/.*\[.*(MUTED).*\].*/\, muted/p' <<< "$STATUS")

    BODY="Mic volume $VOLUME%"

    notify-send "$NAME" "$BODY$MUTED" -h string:synchronous:volume
  '';
}
