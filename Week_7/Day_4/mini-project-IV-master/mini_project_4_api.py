from flask import Flask, jsonify, request
from flask_restful import Resource, Api, reqparse
import pandas as pd
import numpy
import pickle

app = Flask(__name__)
api = Api(app)
    
model = pickle.load(open('log_reg_model.sav', 'rb'))

class Loan_Status_Prediction(Resource):
    def post(self):
        json_data = request.get_json()
        print(json_data)
        df = pd.DataFrame(json_data.values(),
                          index=json_data.keys()).transpose()
        res = model.predict(df)
        
        return res.tolist()
    
api.add_resource(Loan_Status_Prediction, '/loan')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0',port=5000)
    