from flask import Flask, request, jsonify
from flask.logging import create_logger
import logging

#import pandas as pd

import yfinance as yf
from pandas_datareader import data as pdr

from datetime import date

app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)


def last_price(payload):


    ticker = payload['Ticker']
    today = str(date.today())

    yf.pdr_override()
    data = pdr.get_data_yahoo(ticker, start='2019-01-01', end=today)


    # last price
    price = data['Adj Close'][-1]

    return ticker, price




@app.route("/")
def home():
    html = "<h3>Stock pricing API</h3>"
    return html.format(format)

@app.route("/stock_analytics", methods=['POST'])
def stock_analytics():
    """Performs an sklearn prediction
        
        {  
         "Ticker":"AAPL"
        }
        
        result looks like:
        { "ticker": "price" }
        
        """

    today = str(date.today())
    LOG.info(f"Today: {today}")
    
    # Logging the input payload
    json_payload = request.json
    
    # the incoming request is basically a dictionary
    # so is accessible via key
    LOG.info(f"JSON payload: \n{json_payload}")

    # scale the input
    ticker, price = last_price(json_payload)

    LOG.info(f"Price: \n{price}")

    return jsonify({ticker: price})



if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True) # specify port=80







