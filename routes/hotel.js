const express = require('express');
const router = express.Router();
const {fileUploadMiddleware, fileExtLimiterMiddleware, hotelController, getHotel, getHotelByQueries,updateHotelInfo,updateHotelImage,deleteHotel} = require('../controller/hotel_controller');
const {uploadHotelRoom,getHotelRoom,deleteHotelRoom,updateHotelRoom} = require('../controller/hotelRoomController');
const authen = require('../middleware/utils_auth');

router.get('/:id', getHotel);
router.get('/:page',getHotelByQueries)
router.get('/:hotel/room',getHotelRoom)
router.use(authen);
router.post('/', [fileUploadMiddleware, fileExtLimiterMiddleware, hotelController]);
router.post('/:hotel/room',uploadHotelRoom)
router.put('/:id', updateHotelInfo);
router.put('/update_img/:id', [fileUploadMiddleware, fileExtLimiterMiddleware, updateHotelImage]);
router.put('/:hotel/room/:id',updateHotelRoom)
router.delete('/:hotel/room/:id',deleteHotelRoom)
router.delete('/:id', deleteHotel);


module.exports = router;