const TourModel = require('../models/tourModel');
const ArticleModel = require('../models/articleModel');

//all require auth except get
const createTour = async (req, res) => {
    try{
        const tour = new TourModel(req.body);
        await tour.save();
        res.status(200).json({status: "success", message: "Tour created"});
    }
    catch (e) {
        console.log(e.message);
        res.status(503).json({status: "error", message: e.message});
    }
}

const deleteTour = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id)
            return res.status(400).json({status: "error", message: "Missing id"});
        const tour = await TourModel.findById(id);
        if(!tour)
            return res.status(404).json({status: "error", message: "Tour not found"});
        await tour.deleteOne();
        return res.status(200).json({status: "success", message: "Tour deleted"});

    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

//can pass in city, province or referenceName to filter
const getTourList = async (req, res) => {
    try{
        const page = req.params.page || 1;
        const province = req.query.province;
        const city = req.query.city;
        const referenceName = req.query.referenceName;
        const query = TourModel.find();
        let articlesList = [];
        if(province){
            const articles = await ArticleModel.find().where('province', new RegExp(province, 'i'));
            articlesList.push(...articles);
        }
        if(city){
            const articles = await ArticleModel.find().where('city', new RegExp(city, 'i'));
            articlesList.push(...articles);
        }
        if(referenceName){
            const articles = await ArticleModel.find().where('referenceName', new RegExp(referenceName, 'i'));
            articlesList.push(...articles);
        }
        if(articlesList.length > 0){
            const articlesId = articlesList.map(article => article._id);
            query.where('articles').in(articlesId);
        }

        const tours = await query.skip((page - 1) * 10).limit(10).select("_id").exec();

        return res.status(200).json({status: "success", message: "Tours found", data: tours});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getTour = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id)
            return res.status(400).json({status: "error", message: "Missing id"});
        const tour = await TourModel.findById(id);
        if(!tour)
            return res.status(404).json({status: "error", message: "Tour not found"});
        return res.status(200).json({status: "success", message: "Tour found", data: tour});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const updateTour = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id)
            return res.status(400).json({status: "error", message: "Missing id"});
        const tour = await TourModel.findById(id);
        if(!tour)
            return res.status(404).json({status: "error", message: "Tour not found"});
        if(!tour.user.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        const {name, description, price, duration, maxGroupSize, rating, articles, startDates, province, city} = req.body;
        tour.name = name;
        tour.description = description;
        tour.price = price;
        tour.duration = duration;
        tour.maxGroupSize = maxGroupSize;
        tour.rating = rating;
        tour.startDates = startDates;
        tour.articles = articles;
        tour.province = province;
        tour.city = city;
        await tour.save();
        return res.status(200).json({status: "success", message: "Tour updated"});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

module.exports = {createTour, deleteTour, getTourList, getTour, updateTour};