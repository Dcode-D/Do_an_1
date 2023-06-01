const mongoose = require('mongoose');
const {Schema} = require("mongoose");

const FacilitySchema = Schema({
    name: {
        type: String,
        require:true,
        notnull: true,
    },
    description: {
        type: String,

    },
    service: {
        type: Schema.Types.ObjectId,
        require: true,
        notnull: true,
    },
    type: {
        type: String,
        enum: ['car', 'hotel'],
    }
})

module.exports = mongoose.model('Facility', FacilitySchema);