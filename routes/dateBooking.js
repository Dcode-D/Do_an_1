const router = require('express').Router();
const {createDateBooking,deleteDateBooking,approveDateBooking,rejectDateBooking,getBookingById,getBookingsOfUser} = require('../controller/dateBookingController');
const authen = require('../middleware/utils_auth');


router.get('/user',getBookingsOfUser);
router.get('/:id',getBookingById);
router.use(authen);
router.post('/',createDateBooking)
router.delete('/:id',deleteDateBooking)
router.get('/:id/approve',approveDateBooking)
router.get('/:id/reject',rejectDateBooking)
module.exports = router;