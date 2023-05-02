const mongoose = require('mongoose')
const {Schema} = require("mongoose");

const carSchema = Schema({
    licensePlate: {
        type: String,
        require: true,
        notnull: true,
    },
    brand: {
        type: String,
        require: true,
        notnull: true,
    },
    seats: {
        type: Number,
        require: true,
        notnull: true,
    },
    pricePerDay: {
        type: Number,
        require: true,
        notnull: true,
    },
    color: {
        type: String,
        require: true,
    },
    images: {
        type: [Schema.Types.ObjectId],
        require: true,
    },
    description:
        {
            type: String,
            require: true,
        },
    owner: {
        type: Schema.Types.ObjectId,
        require: true,
        notnull: true,
    },
});
module.exports = mongoose.model('Car', carSchema);