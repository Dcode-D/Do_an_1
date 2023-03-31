const mongoose = require('mongoose')
const {Schema} = require("mongoose");

const schema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique: true
    },
    path: {
        type: String,
        required: true,
        unique: true,
    },
    description: {
        type: String,
    },
    attachedId: {
        type: Schema.Types.ObjectId,
    },
    publishDate: {
        type: Date,
        default: Date.now()
    },
    publishBy: {
        type: Schema.Types.ObjectId,
        required: true,
    }
})

module.exports = mongoose.model('File', schema)