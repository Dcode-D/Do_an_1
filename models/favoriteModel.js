const mongoose = require('mongoose');
const {Schema} = require("mongoose");

const FavoriteSchema = Schema({
    user: {
        type: Schema.Types.ObjectId,
        require: true,
        notnull: true,
    },
    element: {
        type: Schema.Types.ObjectId,
        require: true,
        notnull: true,
    },
    type: {
        type: String,
        enum: ['car', 'hotel','tour'],
    }
})

module.exports = mongoose.model('Favorite', FavoriteSchema);