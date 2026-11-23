#!/bin/bash
set -e
docker build -t capstone-web-app:v1 .
docker rm -f capstone-container 2>/dev/null || true
docker run -d --name capstone-container -p 8080:80 capstone-web-app:v1
docker ps --filter "name=capstone-container"
echo ""
echo "Test in browser: http://localhost:8080"
curl -s http://localhost:8080 | head -n 10
