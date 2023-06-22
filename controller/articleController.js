const file_ext_limiter = require("../middleware/file_ext_limiter");
const FileModel = require('../models/files_model');
const path = require("path");
const fs = require("fs");
const Article = require("../models/articleModel");

const articleFileExt = file_ext_limiter(['.jpg', '.png', '.jpeg', '.doc', '.docx', '.pdf']);
const articleImageExt = file_ext_limiter(['.jpg', '.png', '.jpeg']);

//require file upload middleware
const createArticle = async (req, res) => {
    try {
        const {title, city, province, address, referenceName, description} = req.body;

        const newArticle = new Article({
            title : title,
            city : city,
            province : province,
            address : address,
            referenceName : referenceName,
            description : description,
            publishBy : req.user._id,
        });
        await newArticle.save();
        //get image from req
        if(!req.files){
            console.log('No files were uploaded.');
            await newArticle.deleteOne();
            return  res.status(400).send('No files were uploaded.');
        }
        for(const key in req.files) {
            const file = req.files[key];
            const filename = Date.now().toString() + file.name;
            const filepath = path.join(__dirname, '../upload/files', filename)
            const fileModel = new FileModel({
                "name": filename,
                "path": filepath,
                "description": "",
                "attachedId": newArticle._id,
                "publishBy": req.user._id,
            });
            await fileModel.save();
            await file.mv(filepath, (err) => {
                if (err) return res.status(500).json({status: "error", message: err})
            });
        }
        return  res.status(200).json({status: "success", message: "Article created", data: newArticle._id});

    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getMaxPage = async (req, res) => {
    try {
        const {id, city, province, referenceName, publishBy} = req.query;
        const query = Article.countDocuments();
        if (id) query.where('_id').equals(id);
        if (city) query.where('city').equals(city);
        if (province) query.where('province').equals(province);
        if (referenceName) query.where('referenceName').equals(referenceName);
        if (publishBy) query.where('publishBy').equals(publishBy);
        const articles = await query.exec();
        return res.status(200).json({status: "success", data: Math.ceil(articles / 10)});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getArticle = async (req, res) => {
    try {
        const {page} = req.params;
        const {city, province, referenceName, publishBy} = req.query;
        const query = Article.find();
        if (city) query.where('city', new RegExp(city, 'i') );
        if (province) query.where('province', new RegExp(province, 'i') );
        if (referenceName) query.where('referenceName', new RegExp(referenceName, 'i') );
        if (publishBy) query.where('publishBy').equals(publishBy);
        const articles = await query.skip((page - 1) * 10).select('_id').exec();
        return res.status(200).json({status: "success", data: articles});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getArticleById = async (req, res) => {
    try {
        const articleid = req.params.id;
        const article = await Article.findById(articleid);
        if(!article) return res.status(404).json({status: "error", message: "Article not found"});
        let result = {};
        const files = await FileModel.find({attachedId: article._id}).select('_id').exec();
        if (files) {
            result = {_id:article._id,title: article.title, description: article.description, province: article.province, city: article.city, referenceName: article.referenceName, images: files, publishedDate: article.publishedDate, publishBy: article.publishBy};
        }
        return res.status(200).json({status: "success", data: result});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}


const deleteArticle = async (req, res) => {
    try {
        const articleid = req.params.id;
        const article = await Article.findById(articleid);
        if(!article) return res.status(404).json({status: "error", message: "Article not found"});
        if(article.publishBy.equals(req.user._id)){
            return res.status(401).json({status: "error", message: "You are not authorized to delete this article"});
        }
        const articleFiles = await FileModel.find({attachedId: article._id});
        if(articleFiles.length > 0){
            for(const articleFile of articleFiles){
                fs.unlinkSync(articleFile.path)
                await articleFile.deleteOne();
            }
        }
        await article.deleteOne();
        return res.status(200).json({status: "success", message: "Article deleted successfully"});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}



//require file upload middleware
const updateArticleInfo = async (req, res) => {
    try {
        const articleid = req.params.id;
        const article = await Article.findById(articleid);
        if(!article) return res.status(404).json({status: "error", message: "Article not found"});
        if(article.publishBy.equals(req.user._id)){
            return res.status(401).json({status: "error", message: "You are not authorized to update this article"});
        }
        const {title, city, province, address, referenceName, description} = req.body;
        if(title) article.title = title;
        if(city) article.city = city;
        if(province) article.province = province;
        if(address) article.address = address;
        if(referenceName) article.referenceName = referenceName;
        if(description) article.description = description;
        if(req.files){
            for(const key in req.files) {
                const file = req.files[key];
                const filename = Date.now().toString() + file.name;
                const filepath = path.join(__dirname, '../upload/files', filename)
                const fileModel = new FileModel({
                    "name": filename,
                    "path": filepath,
                    "description": "",
                    "attachedId": article._id,
                    "publishBy": req.user._id,
                });
                await fileModel.save();
                await file.mv(filepath, (err) => {
                    if (err) return res.status(500).json({status: "error", message: err})
                });
            }
        }
        await article.save();
        return res.status(200).json({status: "success", message: "Article updated successfully"});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}


module.exports = { createArticle, getArticle, deleteArticle, articleFileExt, articleImageExt, getArticleById, updateArticleInfo, getMaxPage };