const express = require('express');
const router = express.Router();
const logoutcontroller = require('../controller/logout_controller')

/* GET users listing. */
router.use(require('../middleware/utils_auth'))
router.get('/',logoutcontroller)

module.exports = router;