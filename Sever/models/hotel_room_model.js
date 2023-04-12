const mongoose = require('mongoose')
const {Schema} = require("mongoose");

const RoomSchema = Schema({
    number: {
        type: Number,
        require:true,
    },
    hotel: {
        type: Schema.Types.ObjectId,
        require: true,
    },
    adultCapacity: {
        type: Number,
        require: true,
        min: 1,
    },
    childrenCapacity: {
        type: Number,
        require: true,
        min: 0,
    },
    price: {
        type: Number,
        require:true,
        min: 0,
    }
})

module.exports = mongoose.model('HotelRoom', RoomSchema);