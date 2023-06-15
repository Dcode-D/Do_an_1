const router = require('express').Router();
const {createDateBooking,deleteDateBooking,approveDateBooking,rejectDateBooking,getBookingById,getBookingsOfUser, getDateBookingOfHotel, getDateBookingOfCar} = require('../controller/dateBookingController');
const authen = require('../middleware/utils_auth');

router.use(authen);
router.get('/user',getBookingsOfUser);
router.get('/:id',getBookingById);
router.post('/',createDateBooking)
router.delete('/:id',deleteDateBooking)
router.get('/:id/approve',approveDateBooking)
router.get('/:id/reject',rejectDateBooking)
router.get('/hotel/:hotel',getDateBookingOfHotel)
router.get('/car/:car',getDateBookingOfCar)
module.exports = router;