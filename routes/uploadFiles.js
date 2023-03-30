const express = require('express');
const router = express.Router();
const fileUpload = require('express-fileupload');
const path = require('path');
router.use(fileUpload({
    limit: { fileSize: 50 * 1024 * 1024 },
    useTempFiles: true,
    tempFileDir: path.join(__dirname, '../temp'),
    createParentPath: true
}));

router.post('/', (req, res) => {
    try{
        console.log(req.body);
        if (!req.files) {
            console.log('No files were uploaded.');
            return  res.status(400).send('No files were uploaded.');
        }
        const files = req.files;
        Object.keys(files).forEach(key => {
            const filepath = path.join(__dirname, '../upload/files',Date.now().toString()+ files[key].name)
            files[key].mv(filepath, (err) => {
                if (err) return res.status(500).json({ status: "error", message: err })
            })
        })
        // req.files.mv(path.join(__dirname, '../uploads/files',new Date().getMilliseconds().toString() + req.files.name));
        return res.status(200).send('File uploaded!');
    }catch(err){
        console.log(err.message);
        return res.sendStatus(503);
    }
});

module.exports = router;