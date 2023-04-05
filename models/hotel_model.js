const mongoose = require('mongoose')
const {Schema} = require("mongoose");

const HotelSchema = Schema({
    name: {
        type: String,
        require:true,
    },
    address: {
        type: String,
        require: true,
    },
    owner: {
        type: Schema.Types.ObjectId,
        require: true,
    },
    description: {
        type: String,
    },
    images: {
        type: [Schema.Types.ObjectId],
    },
    businessLicense: {
        type: Schema.Types.ObjectId,
    },
    province: {
        type: String,
        require: true,
    }
})

module.exports = mongoose.model('Hotel', HotelSchema);