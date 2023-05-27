const express = require('express');
const router = express.Router();
const {getUserInforById, getUserFullUserInfo,updateUser} = require('../controller/userController');
const auth = require('../middleware/utils_auth');


router.get('/id/:id', getUserInforById);
router.use(auth);
router.get('/full', getUserFullUserInfo);
router.put('/update',updateUser);

module.exports = router;