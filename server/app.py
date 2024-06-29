from flask import Flask, jsonify, request
from pymongo import MongoClient
from bson.objectid import ObjectId

app = Flask(__name__)

# MongoDB configuration
MONGO_URI = "mongodb+srv://ayush91003:Aryan123@crud1.s45kjss.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(MONGO_URI)
db = client['Diet']  # Replace with your actual database name

# Define your User model (example)
class User:
    def __init__(self, user_name, age, weight, height, bmi, gender):
        self.user_name = user_name
        self.age = age
        self.weight = weight
        self.height = height
        self.bmi = bmi
        self.gender = gender

    def to_dict(self):
        return {
            'user_name': self.user_name,
            'age': self.age,
            'weight': self.weight,
            'height': self.height,
            'bmi': self.bmi,
            'gender': self.gender
        }

# Example routes for CRUD operations

@app.route('/')
def home():
    return jsonify(message="Connected to MongoDB"), 200

# Create a new user diet detail
# Create a new user diet detail
@app.route('/api/user-diet-details', methods=['POST'])
def add_user_diet_detail():
    data = request.json
    user_name = data.get('user_name')
    age = data.get('age')
    weight = data.get('weight')
    height = data.get('height')
    bmi = data.get('bmi')
    gender = data.get('gender')

    if user_name and age and weight and height and bmi and gender:
        new_user = User(user_name=user_name, age=age, weight=weight, height=height, bmi=bmi, gender=gender)
        result = db.user_diet_details.insert_one(new_user.to_dict())
        return jsonify(message='User diet detail added successfully', id=str(result.inserted_id)), 201
    else:
        return jsonify(message='Missing required fields'), 400


# Get all user diet details
@app.route('/api/user-diet-details', methods=['GET'])
def get_all_user_diet_details():
    user_diet_details = list(db.user_diet_details.find({}))
    for detail in user_diet_details:
        detail['_id'] = str(detail['_id'])
    return jsonify(user_diet_details), 200

# Get a single user diet detail by ID
@app.route('/api/user-diet-details/<string:detail_id>', methods=['GET'])
def get_user_diet_detail(detail_id):
    try:
        detail = db.user_diet_details.find_one({'_id': ObjectId(detail_id)})
        if detail:
            detail['_id'] = str(detail['_id'])
            return jsonify(detail), 200
        else:
            return jsonify(message='User diet detail not found'), 404
    except Exception as e:
        return jsonify(message=f'An error occurred: {str(e)}'), 500

# Update a user diet detail by ID
@app.route('/api/user-diet-details/<string:detail_id>', methods=['PUT'])
def update_user_diet_detail(detail_id):
    data = request.json
    user_name = data.get('user_name')
    age = data.get('age')
    weight = data.get('weight')
    height = data.get('height')
    bmi = data.get('bmi')
    gender = data.get('gender')

    updated_data = {}
    if user_name:
        updated_data['user_name'] = user_name
    if age:
        updated_data['age'] = age
    if weight:
        updated_data['weight'] = weight
    if height:
        updated_data['height'] = height
    if bmi:
        updated_data['bmi'] = bmi
    if gender:
        updated_data['gender'] = gender

    result = db.user_diet_details.update_one({'_id': ObjectId(detail_id)}, {'$set': updated_data})

    if result.modified_count > 0:
        return jsonify(message='User diet detail updated successfully'), 200
    else:
        return jsonify(message='User diet detail not found'), 404

# Delete a user diet detail by ID
@app.route('/api/user-diet-details/<string:detail_id>', methods=['DELETE'])
def delete_user_diet_detail(detail_id):
    result = db.user_diet_details.delete_one({'_id': ObjectId(detail_id)})

    if result.deleted_count > 0:
        return jsonify(message='User diet detail deleted successfully'), 200
    else:
        return jsonify(message='User diet detail not found'), 404

if __name__ == '__main__':
    app.run(debug=True)
