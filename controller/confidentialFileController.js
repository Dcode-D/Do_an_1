const file_ext_limiter = require("../middleware/file_ext_limiter");
const FileModel = require('../models/files_model');
const path = require("path");
const fs = require("fs");


const confidentialFilesExtOptions = file_ext_limiter(['.jpg', '.png', '.jpeg', '.pdf', '.doc']);

//must have logged in
//must have used express-fileupload middleware
const uploadConfidentialFiles = async (req, res) => {
    try{
        if (!req.files) {
            console.log('No files were uploaded.');
            return  res.status(400).send('No files were uploaded.');
        }
        const files = req.files;
        // console.log("content type: ", req.headers['content-type'])
        // console.log("body: ", req.body)
        for(const key in files){
            const filename = Date.now().toString()+ files[key].name;
            const filepath = path.join(__dirname, '../upload/confidential',filename)
            const fileModel = new FileModel({
                "name": filename,
                "path": filepath,
                "description": req.body.description,
                "attachedId": req.body.attachedId,
                "publishBy": req.user._id,
            });
            await fileModel.save();
            await files[key].mv(filepath, (err) => {
                if (err) return res.status(500).json({ status: "error", message: err })
            })
        }
        // req.files.mv(path.join(__dirname, '../uploads/files',new Date().getMilliseconds().toString() + req.files.name));
        return res.status(200).send('File uploaded!');
    }catch(err){
        console.log(err.message);
        return res.sendStatus(503);
    }
}

const deleteConfidentialFiles = async (req, res) => {
    try{
        if(!req.body.id) return res.status(400).json({status: "error", message: "Missing id"});
        const file = FileModel.findById(req.body.id);
        if(!file) return res.status(404).json({status: "error", message: "File not found"});
        if(file.publishBy !== req.user._id) return res.status(403).json({status: "error", message: "Permission denied"});
        await file.remove();
        fs.unlinkSync(file.path);
        return res.status(200).json({status: "success", message: "File deleted"});
    }catch (err) {
        console.log(err.message);
        return res.sendStatus(503);
    }
}

const getConfidentialFilesById = async (req, res) => {
    try{
        if (!req.params.id) return res.status(400).json({status: "error", message: "Missing id"});
        const file = await FileModel.findById(req.params.id);
        if(!file) return res.status(404).json({status: "error", message: "File not found"});
        if(file.publishBy !== req.user._id||file.attachedId !== req.user._id) return res.status(403).json({status: "error", message: "Permission denied"});
        return res.status(200).sendFile(file.path);
    }catch (e) {
        console.log(e.message);
        return res.sendStatus(503);
    }
}

module.exports = {confidentialFilesExtOptions, uploadConfidentialFiles, deleteConfidentialFiles, getConfidentialFilesById};