const express = require('express');
const router = express.Router();
const fileUpload = require('express-fileupload');
const path = require('path');
const FileModel = require('../models/files_model');
const utils_auth = require('../middleware/utils_auth');
// const multiparty = require('connect-multiparty');
//
// router.use(multiparty({ maxFieldsSize: (50 * 1024 * 1024) }));
// router.use(utils_auth);
// router.use(fileUpload({
//     limit: { fileSize: 50 * 1024 * 1024 },
//     useTempFiles: true,
//     tempFileDir: path.join(__dirname, '../temp'),
//     createParentPath: true,
//     abortOnLimit: true,
// }));
//
// router.post('/', async (req, res) => {
//     try{
//         if (!req.files) {
//             console.log('No files were uploaded.');
//             return  res.status(400).send('No files were uploaded.');
//         }
//         const files = req.files;
//         for(const key in files){
//             const filename = Date.now().toString()+ files[key].name;
//             const filepath = path.join(__dirname, '../upload/files',filename)
//             const fileModel = new FileModel({
//                 "name": filename,
//                 "path": filepath,
//                 "description": req.body.description,
//                 "attachedId": req.body.attachedId,
//                 "publishBy": req.user._id,
//             });
//             await fileModel.save();
//             await files[key].mv(filepath, (err) => {
//                 if (err) return res.status(500).json({ status: "error", message: err })
//             })
//         }
//         // req.files.mv(path.join(__dirname, '../uploads/files',new Date().getMilliseconds().toString() + req.files.name));
//         return res.status(200).send('File uploaded!');
//     }catch(err){
//         console.log(err.message);
//         return res.sendStatus(503);
//     }
// });

module.exports = router;