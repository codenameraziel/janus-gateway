#!/bin/bash

DOMAIN="umbrel.tailc9398a.ts.net"

echo "=== Testando API HTTP Janus ==="
curl -vk https://$DOMAIN/janus/info

echo -e "\n=== Testando WebSocket Janus ==="
npx wscat -c wss://$DOMAIN/ws <<EOF
{"janus":"info","transaction":"123456"}
EOF

echo -e "\n=== Testando API Admin ==="
curl -vk https://$DOMAIN/admin/info

echo -e "\n=== Testando WebSocket Admin ==="
npx wscat -c wss://$DOMAIN/adminws <<EOF
{"janus":"ping","transaction":"abc123"}
EOF

echo -e "\n=== Testando Plugin EchoTest ==="
npx wscat -c wss://$DOMAIN/ws <<EOF
{"janus":"create","transaction":"echotest1"}
{"janus":"attach","plugin":"janus.plugin.echotest","transaction":"echotest2"}
EOF

echo -e "\n=== Testando Plugin VideoRoom (listar salas) ==="
npx wscat -c wss://$DOMAIN/ws <<EOF
{"janus":"create","transaction":"videoroom1"}
{"janus":"attach","plugin":"janus.plugin.videoroom","transaction":"videoroom2"}
{"janus":"message","body":{"request":"list"},"transaction":"videoroom3"}
EOF

echo -e "\n=== Testando Plugin Streaming (listar streams) ==="
npx wscat -c wss://$DOMAIN/ws <<EOF
{"janus":"create","transaction":"streaming1"}
{"janus":"attach","plugin":"janus.plugin.streaming","transaction":"streaming2"}
{"janus":"message","body":{"request":"list"},"transaction":"streaming3"}
EOF
