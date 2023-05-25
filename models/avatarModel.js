const mongoose = require('mongoose');
const {Schema} = require("mongoose");

const avatarSchema = Schema({
    user: {
        type: Schema.Types.ObjectId,
        require: true,
        notnull: true,
    },
    path: {
        type: String,
        require: true,
        notnull: true,
        unique: true,
    },
    createdDate: {
        type: Date,
        default: Date.now,
    }
});

module.exports = mongoose.model('Avatar', avatarSchema);