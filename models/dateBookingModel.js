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
    },
    approved:{
        type: Boolean,
        default: false,
    },
    suspended:{
        type: Boolean,
        default: false,
    },
    type:{
        type: String,
        enum: ['car', 'hotel'],
        require: true,
    }
})

module.exports = mongoose.model('DateBooking', DateBookingSchema);