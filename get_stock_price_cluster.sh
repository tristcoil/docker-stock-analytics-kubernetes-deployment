#!/usr/bin/env bash
ADDRESS='k8s-stockapp-ingresss-e7ce4b8d1f-780911389.us-east-2.elb.amazonaws.com'
PORT=80
ENDPOINT='stock_analytics'
echo "Port: $PORT"

# POST method predict
curl -d '{
   "Ticker":"AAPL"
}'\
     -H "Content-Type: application/json" \
     -X POST ${ADDRESS}:${PORT}/${ENDPOINT}
