const mongoose = require('mongoose');
const {Schema} = require("mongoose");

const TourSchema = Schema({
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
    startDates: {
        type: Date,
        require: true,
    },
    province: {
        type: String,
    },
    city: {
        type: String,
    }
})

module.exports = mongoose.model('Tour', TourSchema);