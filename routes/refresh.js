const express = require('express');
const router = express.Router();
const refreshcontroller = require('../controller/refresh_controller')

/* GET users listing. */
router.use(require('../middleware/untils_auth'))
router.post('/',refreshcontroller)

module.exports = router;