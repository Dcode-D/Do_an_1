const express = require('express');
const router = express.Router();
const fileUploadMiddleware = require("../middleware/fileUpload");
const {AvatarFileExt, uploadAvatar, deleteAvatar, getAvatar, getAvatarByUserId} = require('../controller/avatarController');
const auth = require('../middleware/utils_auth');

router.get('/list/:id', getAvatarByUserId);
router.get('/:id', getAvatar);
router.use(auth);
router.post('/', [fileUploadMiddleware, AvatarFileExt, uploadAvatar]);
router.delete('/:id', deleteAvatar);

module.exports = router;
