const mongoose = require('mongoose')
const {Schema} = require("mongoose");

const RatingSchema = Schema({
    user: {
        type: Schema.Types.ObjectId,
        require:true,
        notnull: true,
    },
    service: {
        type: Schema.Types.ObjectId,
        require: true,
        notnull: true,
    },
    rating: {
        type: Number,
        require:true,
        notnull: true,
    },
    comment: {
        type: String,
    },
    type:{
        type: String,
        require: true,
        notnull: true,
        enum: ['hotel', 'car', 'tour', 'article']
    }
})

module.exports = mongoose.model('Rating', RatingSchema);