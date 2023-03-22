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
        createdAt: { type: Date, expires: 30, default: Date.now }
    }
)

module.exports = mongoose.model('JWT',JWTSchema)