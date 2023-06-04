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
        //get image from req
        if(!req.files){
            console.log('No files were uploaded.');
            return  res.status(400).send('No files were uploaded.');
        }
        const file = Object.values(req.files)[0];
        const filename = Date.now().toString() + file.name;
        const filepath = path.join(__dirname, '../upload/files', filename)
        const fileModel = new FileModel({
            "name": filename,
            "path": filepath,
            "description": req.body.description,
            "attachedId": req.body.attachedId,
            "publishBy": req.user._id,
        });
        await fileModel.save();
        await file.mv(filepath, (err) => {
            if (err) return res.status(500).json({status: "error", message: err})
        })
        let imgfile = fileModel._id;


        const {title, city, province, address, referenceName, shortDescription} = req.body;

        const newArticle = new Article({
            title : title,
            city : city,
            province : province,
            address : address,
            referenceName : referenceName,
            shortDescription : shortDescription,
            imgfile : imgfile,
            publishBy : req.user._id,
        });
        await newArticle.save();
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
        const {id, city, province, referenceName, publishBy} = req.query;
        const query = Article.find();
        if (id) query.where('_id').equals(id);
        if (city) query.where('city', new RegExp(city, 'i') );
        if (province) query.where('province', new RegExp(province, 'i') );
        if (referenceName) query.where('referenceName', new RegExp(referenceName, 'i') );
        if (publishBy) query.where('publishBy').equals(publishBy);
        const articles = await query.skip((page - 1) * 10).exec();
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
        return res.status(200).json({status: "success", data: article});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getArticleContent = async (req, res) => {
    try{
        const articleid = req.params.id;
        const article = await Article.findById(articleid);
        if(!article) return res.status(404).json({status: "error", message: "Article not found"});
        const articleFile = await FileModel.findById(article.article);
        if(!articleFile) return res.status(404).json({status: "error", message: "Article file not found"});
        return res.status(200).sendFile(articleFile.path);
    }
    catch (e) {
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
        const articleFile = await FileModel.findById(article.article);
        const image = await FileModel.findById(article.image);
        if(articleFile){
            fs.unlinkSync(articleFile.path)
            await articleFile.remove();
        }
        if(image){
            fs.unlinkSync(image.path)
            await image.remove();
        }
        await article.remove();
        return res.status(200).json({status: "success", message: "Article deleted successfully"});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const uploadArticle = async (req, res) => {
    try {
        const articleid = req.params.id;
        const article = await Article.findById(articleid);
        if(!article) return res.status(404).json({status: "error", message: "Article not found"});
        if(article.publishBy.equals(req.user._id)){
            return res.status(401).json({status: "error", message: "You are not authorized to update this article"});
        }
        //get image from req
        if(!req.files){
            console.log('No files were uploaded.');
            return  res.status(400).send('No files were uploaded.');
        }
        const file = Object.values(req.files)[0];
        const filename = Date.now().toString() + file.name;
        const filepath = path.join(__dirname, '../upload/files', filename)
        const fileModel = new FileModel({
            "name": filename,
            "path": filepath,
            "description": req.body.description,
            "attachedId": req.body.attachedId,
            "publishBy": req.user._id,
        });
        await fileModel.save();
        await file.mv(filepath, (err) => {
            if (err) return res.status(500).json({status: "error", message: err})
        })
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
        const {title, city, province, address, referenceName, shortDescription} = req.body;
        if(title) article.title = title;
        if(city) article.city = city;
        if(province) article.province = province;
        if(address) article.address = address;
        if(referenceName) article.referenceName = referenceName;
        if(shortDescription) article.shortDescription = shortDescription;
        if(req.files){
            const currentimg = await FileModel.findById(article.image);
            if(currentimg){
                fs.unlinkSync(currentimg.path)
                const newimg = req.file;
                const filename = Date.now().toString() + newimg.name;
                currentimg.path = path.join(__dirname, '../upload/images', filename);
                newimg.mv(currentimg.path, (err) => {
                    if (err) return res.status(500).json({status: "error", message: err})
                })
                currentimg.name = filename;
                await currentimg.save();
            }
        }
        await article.save();
        return res.status(200).json({status: "success", message: "Article updated successfully"});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const updateArticle = async (req, res) => {
    try {
        const articleid = req.params.id;
        const article = await Article.findById(articleid);
        if(!article) return res.status(404).json({status: "error", message: "Article not found"});
        if(article.publishBy.equals(req.user._id)){
            return res.status(401).json({status: "error", message: "You are not authorized to update this article"});
        }
        const content = article.article;
        const contentfile = await FileModel.findById(content);
        if(!contentfile) return res.status(404).json({status: "error", message: "Article content not found"});
        if(req.files){
            const newart = Object.values(req.files)[0];
            const filename = Date.now().toString() + newart.name;
            fs.unlinkSync(contentfile.path)
            contentfile.path = path.join(__dirname, '../upload/files', filename);
            newart.mv(contentfile.path, (err) => {
                if (err) return res.status(500).json({status: "error", message: err})
            })
            await contentfile.save();
            return res.status(200).json({status: "success", message: "Article updated successfully"});
        }
        else {
            return res.status(400).json({status: "error", message: "No file found"});
        }
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

module.exports = { createArticle, getArticle, deleteArticle, articleFileExt, articleImageExt, getArticleById, uploadArticle, updateArticleInfo, updateArticle, getArticleContent, getMaxPage };