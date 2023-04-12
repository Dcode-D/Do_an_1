const express = require('express');
const router = express.Router();
const authcontroller = require('../controller/auth_controller')

/* GET users listing. */
router.post('/',authcontroller)

module.exports = router;