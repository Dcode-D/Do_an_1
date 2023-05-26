const dateBookingModel = require('../models/dateBookingModel');
const hotelModel = require('../models/hotel_model');
const carModel = require('../models/carServiceModel');

const createDateBooking = async (req, res) => {
    try {
        const check = await dateBookingModel.find({bookingDate: req.body.date, attachedService: req.body.service});
        const checkhotel = hotelModel.findById(req.body.service)
        const checkCar = carModel.findById(req.body.service)
        if(!checkhotel && !checkCar) return res.status(404).json({status: "error", message: "Service not found"});
        if (check.length>0) return res.status(400).json({status: "error", message: "Date booking already exists"});
        const dateBooking = new dateBookingModel({
            bookingDate: req.body.date,
            attachedService: req.body.attachedService,
            user: req.user._id,
            note: req.body.note
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
        await dateBooking.remove();
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
        let business = await carModel.findById(datebooking.attachedService);
        if(!business)
            business = await hotelModel.findById(datebooking.attachedService);
        if(!business)
            return res.status(404).json({status: "error", message: "Business not found"});
        const owner = business.owner;
        if(!owner.equals(req.user._id))
            return res.status(403).json({status: "error", message: "Not permitted"});
        datebooking.approved = true;
        await datebooking.save();
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
        let business = await carModel.findById(datebooking.attachedService);
        if(!business)
            business = await hotelModel.findById(datebooking.attachedService);
        if(!business)
            return res.status(404).json({status: "error", message: "Business not found"});
        const owner = business.owner;
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
        const {service, bookingDate, approved, suspended} = req.query;
        const query = dateBookingModel.find({user: req.user._id});
        if(service)
            query.where({attachedService: service});
        if(bookingDate)
            query.where({bookingDate: bookingDate});
        if(approved)
            query.where({approved: approved});
        if(suspended)
            query.where({suspended: suspended});
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

module.exports={createDateBooking,deleteDateBooking, approveDateBooking, rejectDateBooking, getBookingsOfUser, getBookingById};