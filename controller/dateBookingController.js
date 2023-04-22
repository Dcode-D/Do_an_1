const dateBookingModel = require('../models/dateBookingModel');

const createDateBooking = async (req, res) => {
    try {
        const check = await dateBookingModel.find({bookingDate: req.body.date, attachedService: req.body.service});
        if (check.length>0) return res.status(400).json({status: "error", message: "Date booking already exists"});
        const dateBooking = new dateBookingModel({
            bookingDate: req.body.date,
            attachedService: req.body.service,
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

module.exports={createDateBooking,deleteDateBooking}