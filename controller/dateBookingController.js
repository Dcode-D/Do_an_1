const dateBookingModel = require('../models/dateBookingModel');
const hotelModel = require('../models/hotel_model');
const HotelRoomModel = require('../models/hotel_room_model');
const carModel = require('../models/carServiceModel');
const UserModel = require('../models/user_model');

//pass in dateBooking, type, service list in the body
const createDateBooking = async (req, res) => {
    try {
        const {type, attachedServices, startDate, endDate, note} = req.body;
        if (!type || !attachedServices || !startDate || !endDate) return res.status(400).json({status: "error", message: "Missing required fields"});
        if(new Date(startDate)>=new Date(endDate)) return res.status(400).json({status: "error", message: "Start date must be before end date"});
        const check = await dateBookingModel.find().where("type").equals(type)
            .where({attachedServices: {$in: attachedServices}})
            .where({$or:[
                    {$and:[{startDate:{$gte: new Date(startDate)}},{startDate:{$lt: new Date(endDate)}}]},
                    {$and:[{endDate:{$gt: new Date(startDate)}},{endDate:{$lte: new Date(endDate)}}]},
                ]})
            .where("suspended").equals(false).exec();
        if (check.length > 0) return res.status(400).json({
            status: "error",
            message: "Date booking already exists"
        });
        if(type==="hotel"){
            const hotelRooms = await  HotelRoomModel.find({_id:{ $in: attachedServices}});
            if(hotelRooms.length>1){
                for(let i=0;i<hotelRooms.length-1;i++){
                    if(!hotelRooms[i].hotel.equals(hotelRooms[i+1].hotel)) return res.status(400).json({status: "error", message: "Hotel rooms must be in the same hotel"});
                }
            }
        }

        if(type === "car"){
            const cars = await carModel.find({_id: {$in: attachedServices}});
            if(cars.length>1){
                for(let i=0;i<cars.length-1;i++){
                    if(!cars[i].owner.equals(cars[i+1].owner)) return res.status(400).json({status: "error", message: "Cars must be from the same owner"});
                }
            }
        }
        if(type !== "hotel" && type !== "car") return res.status(400).json({status: "error", message: "Invalid type"});

        const dateBooking = new dateBookingModel({
            type: type,
            attachedServices: attachedServices,
            startDate: startDate,
            endDate: endDate,
            user: req.user._id,
            note: note,
        });
        await dateBooking.save();
        return res.status(200).json({status: "success", message: "Date booking created"});
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}


//pass in the body the id of the dateBooking
const deleteDateBooking = async (req, res) => {
    try {
        const dateBooking = await dateBookingModel.findById(req.params.id);
        if (!dateBooking) return res.status(404).json({status: "error", message: "Date booking not found"});
        if (!dateBooking.user.equals(req.user._id)) return res.status(403).json({status: "error", message: "Not permitted"});
        if(!dateBooking.suspended) return res.status(400).json({status: "error", message: "Date booking cannot be removed before suspended"});
        await dateBooking.deleteOne();
        return res.status(200).json({status: "success", message: "Date booking deleted"});
    } catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

//auth required
const approveDateBooking = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id)
            return res.status(400).json({status: "error", message: "Missing id"});
        const datebooking = await dateBookingModel.findById(id);
        if(!datebooking)
            return res.status(404).json({status: "error", message: "Date booking not found"});
        if(datebooking.bookingDate < Date.now())
            return res.status(400).json({status: "error", message: "Date booking already expired"});
        if(datebooking.suspended)
            return res.status(400).json({status: "error", message: "Date booking already suspended"});
        let business;
        if(datebooking.type === "hotel"){
            const tmp = await  HotelRoomModel.find({_id: {$in: datebooking.attachedServices}});
            business = await hotelModel.find({_id: {$in: tmp.map(x=>x.hotel)}})
        }
        else if(datebooking.type === "car"){
            business = await  carModel.find({_id: {$in: datebooking.attachedServices}});
        }
        if(!business)
            return res.status(404).json({status: "error", message: "Business not found"});
        if(business.length>1){
            for(let i=0;i<business.length;i++){
                if(!business[i].owner.equals(req.user._id))
                    return res.status(403).json({status: "error", message: "Not permitted for one or all businesses"});
            }
        }
        const owner = business[0].owner;
        if(!owner.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        datebooking.approved = true;
        await datebooking.save();
        const io = req.app.get('io');
        const user = await  UserModel.findById(datebooking.user);
        io.to(user.username).emit('approveDateBooking', {id: datebooking._id});
        return res.status(200).json({status: "success", message: "Date booking approved"});
    }catch (e) {
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const rejectDateBooking = async (req, res) => {
    try{
        const id = req.params.id;
        if(!id)
            return res.status(400).json({status: "error", message: "Missing id"});
        const  datebooking = await dateBookingModel.findById(id);
        if(!datebooking)
            return res.status(404).json({status: "error", message: "Date booking not found"});
        if(datebooking.bookingDate < Date.now())
            return res.status(400).json({status: "error", message: "Date booking already expired"});
        let business;
        let flag = true;
        let owner;
        if(datebooking.type === "hotel"){
            const tmp = await  HotelRoomModel.find({_id: {$in: datebooking.attachedServices}});
            business = await  hotelModel.find({_id: {$in: tmp.map((item) => item.hotel)}});
        }
        else if(datebooking.type === "car"){
            business = await  carModel.find({_id: {$in: datebooking.attachedServices}});
        }
        if(!business)
            return res.status(404).json({status: "error", message: "Business not found"});
        if(business.length>1){
            for(let i=0;i<business.length-1;i++){
                if(!business[i].owner.equals(business[i+1].owner))
                    flag = false;
            }
        }
        if(flag)
            owner = business[0].owner;

        if(!owner.equals(req.user._id) && !datebooking.user.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        datebooking.suspended = true;
        await datebooking.save();
        return res.status(200).json({status: "success", message: "Date booking suspended"});
    }catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getBookingsOfUser = async (req, res) => {
    try{
        const {services, bookingDate, approved, suspended, page, type} = req.query;
        const query = dateBookingModel.find({user: req.user._id});
        if(services)
            query.where({attachedServices: {$in: services}});
        if(bookingDate)
            query.where({bookingDate: bookingDate});
        if(approved)
            query.where({approved: approved});
        if(suspended)
            query.where({suspended: suspended});
        if(type)
            query.where({type: type});
        if(page)
            query.skip((parseInt(page)-1)*10).limit(10);
        const datebookings = await query.exec();
        return res.status(200).json({status: "success", message: "Date bookings found", data: datebookings});
    }catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getDateBookingOfHotel = async (req, res) => {
    try{
        const hotel = req.params.hotel;
        const {startDate, approved, suspended, endDate, page, attachedServices} = req.query;
        const hotelob = await hotelModel.findById(hotel);
        if(!hotelob)
            return res.status(404).json({status: "error", message: "Hotel not found"});
        if(!hotelob.owner.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        const intPage = parseInt(page);
        const rooms = await HotelRoomModel.find().where({hotel: hotel});
        const query = dateBookingModel.find({attachedServices: {$in:rooms.map(item=>item._id)}, type: "hotel"});
        if(startDate)
            query.where({startDate: new Date(startDate)});
        if(endDate)
            query.where({endDate: new Date(endDate)});
        if(approved)
            query.where({approved: approved});
        if(suspended)
            query.where({suspended: suspended});
        if (attachedServices)
            query.where({attachedServices: {$in: attachedServices}});
        if(page)
            query.skip((intPage-1)*10).limit(10);
        const datebookings = await query.exec();
        return res.status(200).json({status: "success", message: "Date bookings found", data: datebookings});
    }catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getDateBookingOfCar = async (req, res) => {
    try{
        const car = req.params.car;
        const {startDate,endDate, approved, suspended,page,attachedServices,} = req.query;
        const intPage = parseInt(page);
        const carob = await carModel.findById(car);
        if(!carob)
            return res.status(404).json({status: "error", message: "Car not found"});
        if(!carob.owner.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        const query = dateBookingModel.find({attachedServices: {$in: [car]}, type: "car"});
        if(startDate)
            query.where({startDate: new Date(startDate)});
        if(endDate)
            query.where({endDate: new Date(endDate)});
        if(approved)
            query.where({approved: approved});
        if(suspended)
            query.where({suspended: suspended});
        if (attachedServices)
            query.where({attachedService: {$in: attachedServices}});
        if(page)
            query.skip((intPage-1)*10).limit(10);
        const datebookings = await query.exec();
        return res.status(200).json({status: "success", message: "Date bookings found", data: datebookings});
    }catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

const getBookingById = async (req, res) => {
    try{
        const booking = await dateBookingModel.findById(req.params.id);
        if(!booking)
            return res.status(404).json({status: "error", message: "Date booking not found"});

        return res.status(200).json({status: "success", message: "Date booking found", data: booking});
    }
    catch (e){
        console.log(e.message);
        return res.status(503).json({status: "error", message: e.message});
    }
}

module.exports={createDateBooking,deleteDateBooking, approveDateBooking, rejectDateBooking, getBookingsOfUser, getBookingById, getDateBookingOfHotel, getDateBookingOfCar};