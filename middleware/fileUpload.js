const fileUpload = require("express-fileupload");
const path = require("path");
const fileUploadMiddleware = fileUpload({
    limit: { fileSize: 50 * 1024 * 1024 },
    useTempFiles: true,
    tempFileDir: path.join(__dirname, '../temp'),
    createParentPath: true,
    abortOnLimit: true,
});

module.exports = fileUploadMiddleware;