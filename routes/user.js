const express = require('express');
const router = express.Router();
const {getUserInforById, getUserFullUserInfoById} = require('../controller/userController');
const auth = require('../middleware/utils_auth');


router.get('/:id', getUserInforById);
router.use(auth);
router.get('/full/:id', getUserFullUserInfoById);

module.exports = router;