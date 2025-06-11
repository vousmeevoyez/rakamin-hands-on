# DNS Event Filter

This script filters and aggregates suspicious DNS query events from a Suricata `eve.json` log file using `jq`. It targets DNS requests that include keywords associated with authentication or login attempts, while excluding domains from known, legitimate providers.

## Usage

```sh
jq -r '
  select(.event_type == "dns" and (.dns.rrname? // "" | test("authenticat|verif|login|secure|g(oo|0|o0)gle", "i")))
  | select(.dns.rrname | test(
      "(dyngate|microsoft|msftncsi|windowsupdate|office|skype|azure(edge)?|msn|bing|clarity|akadns|akamaized?|gstatic|google(usercontent)?|doubleclick|live|sfx\\.ms|lpsnmedia|liveperson|vidyard|yahoo|ntp|nist|apple|cloudflare|linkedin|teamviewer|3lift|innovid|nvidia|wns|windows|ms|bluemoontuesday|login\\.microsoftonline|static\\.edge\\.microsoftapp|oneclient\\.sfx|px\\.owneriq|x\\.ns\\.gin\\.ntt|ntp\\.time\\.nl|ntp\\.time\\.in\\.ua|ntp\\.nict\\.jp)\\.(com|net|org|ms|gov|jp|nl|ua)$"; "i"
    ) | not)
  | .dns.rrname
' eve.json | sort | uniq -c | sort -nr
o
