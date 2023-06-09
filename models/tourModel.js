const mongoose = require('mongoose');
const {Schema} = require("mongoose");

const TourSchema = Schema({
    user:{
        type: Schema.Types.ObjectId,
        require: true,
        notnull: true,
    },
    name: {
        type: String,
        require:true,
        notnull: true,
    },
    description: {
        type: String,
    },
    articles: {
        type: [Schema.Types.ObjectId],
        require: true,
        notnull: true,
    },
    hotels: {
        type: [Schema.Types.ObjectId],
    },
    price: {
        type: Number,
        require: true,
        notnull: true,
    },
    rating: {
        type: Number,
        default: 0,
        require: true,
    },
    duration: {
        type: Number,
        require: true,
    },
    maxGroupSize: {
        type: Number,
        require: true,
    },
})

module.exports = mongoose.model('Tour', TourSchema);