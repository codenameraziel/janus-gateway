#!/bin/bash

JANUS_URL="http://localhost:8088/janus"

# 1. Criar sessão
SESSION=$(curl -s -X POST $JANUS_URL \
  -H "Content-Type: application/json" \
  -d '{"janus":"create","transaction":"123"}' | jq -r '.data.id')

echo "Sessão criada: $SESSION"

# 2. Anexar plugin de streaming
HANDLE=$(curl -s -X POST $JANUS_URL/$SESSION \
  -H "Content-Type: application/json" \
  -d '{"janus":"attach","plugin":"janus.plugin.streaming","transaction":"124"}' | jq -r '.data.id')

echo "Handle criado: $HANDLE"

# 3. Listar mountpoints
curl -s -X POST $JANUS_URL/$SESSION/$HANDLE \
  -H "Content-Type: application/json" \
  -d '{"janus":"message","body":{"request":"list"},"transaction":"125"}' | jq .
