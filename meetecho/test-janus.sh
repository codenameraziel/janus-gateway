#!/bin/bash

DOMAIN="umbrel.tailc9398a.ts.net"

echo "=== Testando API HTTP Janus ==="
curl -vk https://$DOMAIN/janus/info || echo "Falha na API Janus"

echo -e "\n=== Testando WebSocket Janus ==="
npx wscat -c wss://$DOMAIN/ws <<EOF
{"janus":"info","transaction":"123456"}
EOF

echo -e "\n=== Testando API Admin ==="
curl -vk https://$DOMAIN/admin/info || echo "Falha na API Admin"

echo -e "\n=== Testando WebSocket Admin ==="
npx wscat -c wss://$DOMAIN/adminws <<EOF
{"janus":"ping","transaction":"abc123"}
EOF
