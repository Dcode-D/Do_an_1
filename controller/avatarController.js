const AvatarModel = require('../models/avatarModel');
const FileUploadExt = require('../middleware/file_ext_limiter');
const path = require("path");
const fs = require("fs");

const AvatarFileExt = FileUploadExt(['.jpg', '.png', '.jpeg']);

//all require auth
//require file upload middleware
const uploadAvatar = async (req, res) => {
    try{
        if (req.user._id.equals(avatar.user)) {
            if(!req.files){
                console.log('No files were uploaded.');
                return  res.status(400).send('No files were uploaded.');
            }
            const files = req.files;
            const filename = Date.now().toString() + files[0].name;
            const filepath = path.join(__dirname, '../upload/avatars', filename)
            await files[0].mv(filepath, (err) => {
                if (err) return res.status(500).json({status: "error", message: err})
            })
            const newAvatar = new AvatarModel({
                user : req.user._id,
                path : filepath,
            });
            await newAvatar.save();
        } else {
            return res.status(400).json({status: "error", message: "Not allowed"});
        }
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getAvatarInfo = async (req, res) => {
    const avatarid = req.params.id;
    try {
        const avatar = await AvatarModel.findOne({_id: avatarid});
        if (!avatar) return res.status(404).json({status: "error", message: "Not found"});
        return res.status(200).json({status: "success", data: avatar.createdDate});
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getAvatar = async (req, res) => {
    const id = req.params.id;
    try {
        const avatar = await AvatarModel.findById(id)
        if (!avatar) return res.status(404).json({status: "error", message: "Not found"});
        return res.status(200).sendFile(avatar.path);
    }
    catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const deleteAvatar = async (req, res) => {
    const avatarid = req.params.id;
    try {
        const avatar = await AvatarModel.findOne({_id: avatarid});
        if (!avatar) return res.status(404).json({status: "error", message: "Not found"});
        if (req.user._id.equals(avatar.user)) {
            fs.unlinkSync(avatar.path);
            avatar.remove();
        }
    }
    catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

module.exports = { uploadAvatar, getAvatarInfo, getAvatar, deleteAvatar };