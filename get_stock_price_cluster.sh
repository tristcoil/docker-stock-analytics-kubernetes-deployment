#!/usr/bin/env bash
ADDRESS='k8s-stockapp-ingresss-e7ce4b8d1f-1908406763.us-east-2.elb.amazonaws.com'
PORT=80
ENDPOINT='stock_analytics'
echo "Port: $PORT"


echo 'last yahoo finance stock price'
echo 'can be from previous trading day since it updates after market close'

# POST method predict
curl -d '{
   "Ticker":"AAPL"
}'\
     -H "Content-Type: application/json" \
     -X POST ${ADDRESS}:${PORT}/${ENDPOINT}
