#!/bin/bash

JANUS_URL="http://umbrel:8088/janus"

# 1. Criar sessão
SESSION=$(curl -s -X POST $JANUS_URL \
  -H "Content-Type: application/json" \
  -d '{"janus":"create","transaction":"t1"}' | jq -r '.data.id')
echo "Sessão criada: $SESSION"

# 2. Anexar ao plugin streaming
HANDLE=$(curl -s -X POST $JANUS_URL/$SESSION \
  -H "Content-Type: application/json" \
  -d '{"janus":"attach","plugin":"janus.plugin.streaming","transaction":"t2"}' | jq -r '.data.id')
echo "Handle criado: $HANDLE"

# 3. Watch no mountpoint id=3 (OctoPrint)
curl -s -X POST $JANUS_URL/$SESSION/$HANDLE \
  -H "Content-Type: application/json" \
  -d '{"janus":"message","body":{"request":"watch","id":3},"transaction":"t3"}'

# 4. Start streaming
curl -s -X POST $JANUS_URL/$SESSION/$HANDLE \
  -H "Content-Type: application/json" \
  -d '{"janus":"message","body":{"request":"start"},"transaction":"t4"}'
