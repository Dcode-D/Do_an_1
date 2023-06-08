const jwtBlacklist = require("../middleware/jwt_blacklist");
const passport = require("../middleware/passport_auth");
const socketio = require("socket.io");
const jwtModel = require("../models/jwt_model");
const io = socketio();

const wrapMiddlewareForSocketIo = middleware => (socket, next) => middleware(socket.request, {}, next);
// io.use((socket,next)=>{
//     console.log(socket.handshake.headers.authorization)
//     next()
// })
io.use(async (socket, next) => {
    if(!socket.handshake.headers.authorization) return next(new Error('Authentication error'));
    const auth = socket.handshake.headers.authorization;
    if(auth?.startsWith('Bearer ')){
        const token = auth.split(' ')[1];
        const filter = {"jwtdata": token};
        const foundjwt = await jwtModel.findOne(filter);
        if(foundjwt){
            if(foundjwt.revoked){
                console.log('socketio auth failed')
                return next(new Error('Authentication error'));
            }
            else {
                console.log('socketio auth success');
                return next();
            }
        }
    }
    console.log('socketio auth failed')
    return next(new Error('Authentication error'));
});
io.use(wrapMiddlewareForSocketIo(passport.initialize()));
io.use(wrapMiddlewareForSocketIo(passport.authenticate('jwt', {session: false})));
io.on('connection', (socket) => {
    socket.join(socket.request.user.username);
    console.log(socket.request.user.username+' connected');
    socket.on('disconnect', () => {
        console.log(socket.request.user.username+' disconnected');
    });
    // console.log("user connected");
})

module.exports = io;