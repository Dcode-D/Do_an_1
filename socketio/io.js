const jwtBlacklist = require("../middleware/jwt_blacklist");
const passport = require("../middleware/passport_auth");
const socketio = require("socket.io");
const jwtModel = require("../models/jwt_model");
const io = socketio();
io.use(async (socket, next) => {
    if(!socket.request.extraHeaders?.authorization) return next(new Error('Authentication error'));
    const auth = socket.request.extraHeaders?.authorization;
    if(auth?.startsWith('Bearer ')){
        const token = auth.split(' ')[1];
        const filter = {"jwtdata": token};
        const foundjwt = await jwtModel.findOne(filter);
        if(foundjwt){
            if(foundjwt.revoked){
                return next(new Error('Authentication error'));
            }
            else {
                return next();
            }
        }
    }
    return next(new Error('Authentication error'));
});
io.use(passport.authenticate('jwt', {session: false}));
io.on('connection', (socket) => {
    socket.join(socket.request.user.username);
    console.log(socket.request.user.username+' user connected');
})

module.exports = io;