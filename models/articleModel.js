const mongoose = require('mongoose')
const {Schema} = require("mongoose");

articleSchema = Schema({
    title: { type: String, require: true, notnull: true },
    image:{ type: Schema.Types.ObjectId, require: true, notnull: true },
    shortDescription: { type: String, require: true},
    city: { type: String, require: true, notnull: true },
    province: { type: String, require: true, notnull: true },
    address: { type: String, require: true, notnull: true },
    referenceName: { type: String, require: true, notnull: true },
    article:{ type: Schema.Types.ObjectId},
    publishBy: { type: Schema.Types.ObjectId, require: true, notnull: true },
    publishedDate: { type: Date, default: Date.now },
});
module.exports = mongoose.model('Article', articleSchema);