const FilesModel = require('../models/files_model');
const fs = require('fs');
const path = require('path');

const getFilesById = async (req, res) => {
    const id = req.params.id;
    try {
        const files = await FilesModel.find({_id: id});
        if(files.length === 0) return res.status(404).json({status: "error", message: "File not found"});
        const dirname = path.dirname(files[0].path).split(path.sep).pop();
        if(dirname !== 'files'&& dirname !== 'images')
            return res.status(403).json({status: "error", message: "Invalid file request"});
        return res.status(200).sendFile(files[0].path);
    } catch (e) {
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

module.exports = { getFilesById}