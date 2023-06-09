const express = require('express');
const router = express.Router();
const {fileUploadMiddleware, fileExtLimiterMiddleware, hotelController, getHotel, getHotelByQueries,updateHotelInfo,uploadHotelImage,deleteHotel,deleteHotelImage,updateHotelImage,getMaxPage, deleteFacilities} = require('../controller/hotel_controller');
const {uploadHotelRoom,getHotelRoom,deleteHotelRoom,updateHotelRoom, getRoomById} = require('../controller/hotelRoomController');
const authen = require('../middleware/utils_auth');

router.get('/id/:id', getHotel);
router.get('/page', getMaxPage);
router.get('/page/:page',getHotelByQueries)
router.get('/hotelRoom/:id',getRoomById)
//pass in query: day -> get only available room for that day
router.get('/:hotel/room',getHotelRoom)
router.use(authen);
router.post('/', [fileUploadMiddleware, fileExtLimiterMiddleware, hotelController]);
router.post('/:hotel/room',uploadHotelRoom)
router.put('/:id', updateHotelInfo);
router.post('/upload_img/:id', [fileUploadMiddleware, fileExtLimiterMiddleware, uploadHotelImage]);
router.put('/:hotel/room/:id',updateHotelRoom)
router.delete('/:hotel/room/:id',deleteHotelRoom)
router.delete('/:id', deleteHotel);
router.delete('/delete_img/:id', deleteHotelImage);
//require imageId in body
router.put('/update_img/:id', [fileUploadMiddleware, fileExtLimiterMiddleware, updateHotelImage])

module.exports = router;