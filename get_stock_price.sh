#!/usr/bin/env bash

PORT=8000
echo "Port: $PORT"

# POST method predict
curl -d '{  
   "Ticker":"AAPL"
}'\
     -H "Content-Type: application/json" \
     -X POST http://localhost:$PORT/stock_analytics
