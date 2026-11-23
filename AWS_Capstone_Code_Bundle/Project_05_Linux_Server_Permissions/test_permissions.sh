#!/bin/bash
echo "=== Verifying Group Memberships ==="
id alice
id bob

echo ""
echo "=== Test 1: Allowed Access (alice in devteam) ==="
su - alice -c "cat /opt/secure_app/config.txt"

echo ""
echo "=== Test 2: Denied Access (bob in auditgroup) ==="
su - bob -c "cat /opt/secure_app/config.txt" || true
