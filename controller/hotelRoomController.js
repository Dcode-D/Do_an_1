const hotelRoomModel = require('../models/hotel_room_model');
const dateBookingModel = require('../models/dateBookingModel');
const hotelModel = require('../models/hotel_model');

const updateHotelRoom = async (req, res) => {
    try {
        const hotel = await hotelModel.findById(req.params.hotel);
        if (!hotel || !hotel.owner.equals(req.user._id)) {
            return res.status(403).json({status: "error", message: "Not permitted"});
        }
        if (req.params.id) {
            const hotelRoom = await hotelRoomModel.findById(req.params.id);
            if (!hotelRoom) return res.status(404).json({status: "error", message: "Hotel room not found"});
            if (req.body.number) hotelRoom.number = req.body.number;
            if (req.body.adultCapacity) hotelRoom.adultCapacity = req.body.adultCapacity;
            if (req.body.childrenCapacity) hotelRoom.childrenCapacity = req.body.childrenCapacity;
            if (req.body.price) hotelRoom.price = req.body.price;
            if (req.body.checkInHour) hotelRoom.checkInHour = req.body.checkInHour;
            if (req.body.checkOutHour) hotelRoom.checkOutHour = req.body.checkOutHour;
            if (req.body.checkInMinute) hotelRoom.checkInMinute = req.body.checkInMinute;
            if (req.body.checkOutMinute) hotelRoom.checkOutMinute = req.body.checkOutMinute;
            await hotelRoom.save();
            return res.status(200).json({status: "success", message: "Hotel room updated"});
        }
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const deleteHotelRoom = async (req, res) => {
    try {
        const hotel = await hotelModel.findById(req.params.hotel);
        if (!hotel || !hotel.owner.equals(req.user._id)) {
            return res.status(403).json({status: "error", message: "Not permitted"});
        }
        if (req.params.id) {
            const hotelRoom = await hotelRoomModel.findById(req.params.id);
            if (!hotelRoom) return res.status(404).json({status: "error", message: "Hotel room not found"});
            await hotelRoom.deleteOne();
            return res.status(200).json({status: "success", message: "Hotel room deleted"});
        }
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const uploadHotelRoom = async (req,res)=>{
    try{
        if(!req.params.hotel){
            console.log("no hotel id");
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
        const hotel = await hotelModel.find({_id: req.params.hotel});
        if(!hotel||hotel.length===0||!hotel[0].owner.equals(req.user._id)){
            console.log("invalid hotel id");
            return res.status(400).json({status: "error", message: "Invalid hotel id"});
        }
        const hotelRoomlist = req.body.hotelRooms;
        if(!hotelRoomlist||hotelRoomlist.length===0){
            return res.status(400).json({status: "error", message: "No hotel room information"});
        }
        if(!req.user._id.equals(hotel[0].owner)){
            console.log("invalid hotel id");
            return res.status(400).json({status: "error", message: "Invalid hotel id"});
        }
        for(let htr of hotelRoomlist) {
            const hotelRoom = new hotelRoomModel({
                "number": htr.number,
                "hotel": req.params.hotel,
                "adultCapacity": htr.adultCapacity,
                "childrenCapacity": htr.childrenCapacity,
                "price": htr.price,
                "checkInHour": htr.checkInHour,
                "checkInMinute": htr.checkInMinute,
                "checkOutHour": htr.checkOutHour,
                "checkOutMinute": htr.checkOutMinute,
            });
            await hotelRoom.save();
        }
        res.status(200).send('Hotel room information uploaded');
    }catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

//pass in by query of startDate and endDate to retrieve room available for that day
const getHotelRoom = async (req,res)=>{
    try{
        const listHotelRoom = await hotelRoomModel.find({hotel: req.params.hotel});
        const query = dateBookingModel.find({}).where("type").equals("hotel").where("attachedServices").in(listHotelRoom).where("suspended").equals(false);
        let notAvailableList = [];
        if(req.query.startDate&&req.query.endDate){
            let startDate = req.query.startDate;
            let endDate = req.query.endDate;
            const tmplist = await query.where(
                {
                    $or:[
                        {$and:[
                                {startDate:{$lte: new Date(startDate)}},
                                {endDate:{$gt: new Date(startDate)}}
                            ]},
                        {$and:[
                                {startDate:{$lt: new Date(endDate)}},
                                {endDate:{$gte: new Date(endDate)}}
                            ]},
            ],
                }).where({suspended: false})
                .select('attachedServices').exec();
            for(let tmp of tmplist){
                for(let service of tmp.attachedServices){
                    notAvailableList.push(service);
                }
            }
        }
        if(!req.params.hotel){
            return res.status(400).json({status: "error", message: "No hotel id"});
        }
        const hotelRoom = await hotelRoomModel.find({hotel: req.params.hotel}).where('_id').nin(notAvailableList).exec();
        return res.status(200).json({status: "success", data: hotelRoom});
    }
    catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const  getRoomById = async (req,res)=>{
    try{
        const hotelRoom = await hotelRoomModel.findById(req.params.id);
        if(!hotelRoom){
            return res.status(404).json({status: "error", message: "Hotel room not found"});
        }
        return res.status(200).json({status: "success", data: hotelRoom});
    }
    catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}
module.exports = {updateHotelRoom, deleteHotelRoom, uploadHotelRoom, getHotelRoom, getRoomById};