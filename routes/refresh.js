const express = require('express');
const router = express.Router();
const refreshcontroller = require('../controller/refresh_controller')

/* GET users listing. */
router.post('/',refreshcontroller)

module.exports = router;