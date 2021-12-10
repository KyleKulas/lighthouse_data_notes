from flask import Flask, jsonify, request
from flask_restful import Resource, Api, reqparse
import pandas as pd
import numpy
import pickle

app = Flask(__name__)
api = Api(app)
    
model = pickle.load(open('log_reg_model.sav', 'rb'))

class Scoring(Resource):
    def post(self):
        json_data = request.get_json()
        df = pd.DataFrame(json_data.values(),
                          index=json_data.keys()).transpose()
        res = model.predict(df)
        
        return res.tolist()
    
api.add_resource(Scoring, '/scoring')

if __name__ == '__main__':
    app.run(debug=True,  port=5000)
    