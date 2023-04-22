const router = require('express').Router();
const {createDateBooking,deleteDateBooking} = require('../controller/dateBookingController');
const authen = require('../middleware/utils_auth');

router.use(authen);
router.post('/',createDateBooking)
router.delete('/:id',deleteDateBooking)

module.exports = router;