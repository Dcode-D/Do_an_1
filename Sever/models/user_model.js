const mongoose = require('mongoose');
const {Schema} = require("mongoose");


const UserSchema = new Schema({
    username:{
        type:String,
        required: true,
        unique:true
    },
    password:{
        type: String,
        required: true
    },
    gender :{
        type:Number,
        required:true,
        range:{
            min:{type:Number, value:0},
            max:{type:Number, value: 1}
        }
    },
    email:{
        type:String,
        required:true,
        unique: true,
    },
    firstname:{
        type:String,
        required:true
    },
    lastname:{
        type:String,
        required:true
    },
    address:String,
    phonenumber:{
        type:String,
    }

});

module.exports = mongoose.model('User', UserSchema);