const ratingModel = require("../models/rating_model");

const createRating = async (req, res) => {
    try {
        const rating = new ratingModel({
            rating: req.body.rating,
            comment: req.body.comment,
            user: req.user._id,
            service: req.body.service,
            type: req.body.type
        });
        await rating.save();
        return res.status(200).json({status: "success", message: "Rating created"});
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const updateRating = async (req, res) => {
    try {
        const rating = await ratingModel.findById(req.params.id);
        if (!rating) return res.status(404).json({status: "error", message: "Rating not found"});
        if (!rating.user.equals(req.user._id)) return res.status(403).json({status: "error", message: "Not permitted"});
        rating.rating = req.body.rating;
        rating.comment = req.body.comment;
        await rating.save();
        return res.status(200).json({status: "success", message: "Rating updated"});
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const deleteRating = async (req, res) => {
    try {
        const rating = await ratingModel.findById(req.params.id);
        if (!rating) return res.status(404).json({status: "error", message: "Rating not found"});
        if (!rating.user.equals(req.user._id)) return res.status(403).json({status: "error", message: "Not permitted"});
        await rating.deleteOne();
        return res.status(200).json({status: "success", message: "Rating deleted"});
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getRatings = async (req, res) => {
    try {
        const dbquery = ratingModel.find({});
        const page = parseInt(req.query.page);
        const queries = req.query;
        if(queries.service) dbquery.where({service: queries.service});
        if(queries.user) dbquery.where({user: queries.user});
        if(queries.rating) dbquery.where({rating: queries.rating});
        if(page) dbquery.skip(10*(page-1)).limit(10);
        const ratings = await dbquery.exec();
        return res.status(200).json({status: "success", data: ratings});
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getMaxPage = async (req, res) => {
    try {
        const dbquery = ratingModel.find({});
        const queries = req.query;
        if(queries.service) dbquery.where({service: queries.service});
        if(queries.user) dbquery.where({user: queries.user});
        if(queries.rating) dbquery.where({rating: queries.rating});
        const ratings = await dbquery.exec();
        return res.status(200).json({status: "success", data: Math.ceil(ratings.length/10)});
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

//pass in the type and service id
const getGeneralRating = async (req, res) => {
    try{
        const dbquery = ratingModel.find({type: req.params.type, service: req.params.service});
        const ratings = await dbquery.exec();
        let total = 0;
        for(let i = 0; i < ratings.length; i++){
            total += ratings[i].rating;
        }
        return res.status(200).json({status: "success", data: total/ratings.length});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}


module.exports = {createRating, updateRating, deleteRating, getRatings, getMaxPage, getGeneralRating}