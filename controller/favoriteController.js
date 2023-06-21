//require auth applied for all path
const Favorite = require('../models/favoriteModel');
const createFavorite = async (req, res) => {
    try{
        const {type} = req.params;
        const {element} = req.body;
        const user = req.user._id;
        const favorite = new Favorite({
            user: user,
            element: element,
            type: type
        })
        await favorite.save();
        return res.status(200).json({status: "success", message: "Favorite created"});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const deleteFavorite = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id)
            return res.status(400).json({status: "error", message: "Missing id"});
        const favorite = await Favorite.findById(id);
        if(!favorite)
            return res.status(404).json({status: "error", message: "Favorite not found"});
        if(!favorite.user.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        await favorite.deleteOne();
        return res.status(200).json({status: "success", message: "Favorite deleted"});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getFavorite = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id)
            return res.status(400).json({status: "error", message: "Missing id"});
        const favorite = await Favorite.findById(id);
        if(!favorite)
            return res.status(404).json({status: "error", message: "Favorite not found"});
        if(!favorite.user.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        return res.status(200).json({status: "success", message: "Favorite found", data: favorite});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getUserFavoriteId = async (req, res) => {
    try{
        const type = req.params.type;
        const user = req.user._id;
        const favorite = await Favorite.find({user: user, type: type}).select('_id');
        return res.status(200).json({status: "success", message: "Favorite found", data: favorite});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getIsFavorite = async (req, res) => {
    try{
        const type = req.params.type;
        const user = req.user._id;
        const service = req.params.service;
        const favorite = await Favorite.find({user: user, type: type, element: service});
        if(favorite.length === 0)
            return res.status(200).json({status: "success", message: "Favorite not found", data: ""});
        return res.status(200).json({status: "success", message: "Favorite found", data: favorite[0]._id});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

module.exports = {createFavorite, deleteFavorite, getFavorite, getUserFavoriteId, getIsFavorite};