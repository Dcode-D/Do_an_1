const FilesModel = require('../models/files_model');
const fs = require('fs');
const path = require('path');

const getFilesById = async (req, res) => {
    const id = req.params.id;
    try {
        const files = await FilesModel.find({_id: id});
        if(files.length === 0) return res.status(404).json({status: "error", message: "File not found"});
        const dirname = path.dirname(files[0].path).split(path.sep).pop();
        if(dirname !== 'files'&& dirname !== 'images' && dirname !== 'avatars')
            return res.status(403).json({status: "error", message: "Invalid file request"});
        return res.status(200).sendFile(files[0].path);
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const updateFile = async (req, res) => {
    const id = req.params.id;
    try {
        const file = await  FilesModel.findById(id);
        if(!file) return res.status(404).json({status: "error", message: "File not found"});
        if(!file.publishBy.equals(req.user._id)){
            return  res.status(401).json({status: "error", message: "You are not authorized to update this file"});
        }
        const {name, description} = req.body;
        if(name) file.name = name;
        if(description) file.description = description;
        if(req.files){
            const filetosave = Object.values(req.files)[0];
            if(path.extname(filetosave.name)!==path.extname(file.name))
                return res.status(400).json({status: "error", message: "File extension not allowed"});
            const filename = Date.now().toString() + filetosave.name;
            const filepath = path.join(__dirname, '../upload/files', filename)
            filetosave.mv(filepath, async (err) => {
                if(err) return res.status(503).json({status: "error", message: err.message});});
            file.name = filename;
            file.path = filepath;
            }
        await file.save();
        return res.status(200).json({status: "success", message: "File updated successfully"});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const deleteFile = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id) return res.status(404).json({status: "error", message: "File not found"});
        const file = await FilesModel.findById(id);
        if(!file) return res.status(404).json({status: "error", message: "File not found"});
        if(!file.publishBy.equals(req.user._id)){
            return  res.status(401).json({status: "error", message: "You are not authorized to delete this file"});
        }
        fs.unlinkSync(file.path);
        await file.remove();
        return res.status(200).json({status: "success", message: "File deleted successfully"});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

// const getFilesByHotelId = async (req, res) => {
//     const id = req.params.id;
//     try {
//         const files = await FilesModel.find({attachedId: id});
//         return res.status(200).sendFile(files);
//     }catch (e) {
//         console.log(e.message);
//         return res.status(503).json({status: "error", message: e.message});
//     }
// }

module.exports = { getFilesById, deleteFile, updateFile}