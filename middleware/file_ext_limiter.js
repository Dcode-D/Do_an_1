const path = require("path")

const fileExtLimiter = (allowedExtArray) => {
    return (req, res, next) => {
        if(!req.files) return next()
        if(req.files.files)
            req.files = req.files.files
        if(allowedExtArray.includes("*")) return next()
        const files = req.files

        const fileExtensions = []
        for(const key in files){
            fileExtensions.push(path.extname(files[key].name))
        }

        // Are the file extension allowed?
        const allowed = fileExtensions.every(ext => allowedExtArray.includes(ext))

        if (!allowed) {
            const message = `Upload failed. Only ${allowedExtArray.toString()} files allowed.`.replaceAll(",", ", ");

            return res.status(422).json({ status: "error", message });
        }

        next()
    }
}

module.exports = fileExtLimiter