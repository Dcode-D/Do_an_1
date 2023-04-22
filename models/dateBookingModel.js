const mongoose = require('mongoose')
const {Schema} = require("mongoose");

const DateBookingSchema = Schema({
    attachedService: {
        type: Schema.Types.ObjectId,
        require: true,
    },
    bookingDate: {
        type: Date,
        require: true,
    },
    user:{
        type: Schema.Types.ObjectId,
        require: true,
    },
    note:{
        type: String,
    }
})

module.exports = mongoose.model('DateBooking', DateBookingSchema);