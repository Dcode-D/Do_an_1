const FileModel = require('../models/files_model');
const path = require("path");

const uploadFile = async (file, dirname, description, attachedid, publishedby) =>{
    try{
        const filename = Date.now().toString() + file.name;
        const filepath = path.join(__dirname, '../upload/'+dirname+'/', filename)
        const fileModel = new FileModel({
            "name": filename,
            "path": filepath,
            "description": description,
            "attachedId":attachedid,
            "publishBy": publishedby,
        });
        await fileModel.save();
        await file.mv(filepath, (err) => {
            if (err) return ""
        })
            return fileModel._id;
    }
    catch(e){
        console.log(e.message);
        throw new Error(e.message);
    }
}

module.exports = uploadFile;