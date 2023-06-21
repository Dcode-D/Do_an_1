const mongoose = require('mongoose')
const {Schema} = require("mongoose");

const DateBookingSchema = Schema({
    attachedServices: {
        type: [Schema.Types.ObjectId],
        require: true,
        notnull: true,
    },
    startDate: {
        type: Date,
        require: true,
    },
    endDate: {
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
    },
    price:{
        type: Number,

    }
})

module.exports = mongoose.model('DateBooking', DateBookingSchema);