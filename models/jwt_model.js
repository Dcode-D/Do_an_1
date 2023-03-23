const mongoose = require('mongoose')
const {Schema} = require("mongoose");
const schema = mongoose.Schema

JWTSchema = new Schema(
    {
        jwtdata:{
            type: String,
            require:true
        },
        revoked:{
            type:Boolean,
            require: true
        },
        userid:{
            type:Schema.Types.ObjectId,
            ref:'User'
        },
        expireAt: {
            type: Date,
            default: Date.now() +3600*1000*24,
        }
    }
)
module.exports = mongoose.model('JWT',JWTSchema)