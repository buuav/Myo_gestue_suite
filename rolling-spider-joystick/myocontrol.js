

var net = require('net');

var HOST = '128.197.50.236';
var PORT = 55000;
var n=1;
var client = new net.Socket();

var RollingSpider = new require('rolling-spider');
var quad = new RollingSpider({
    logger: console.log
});

var flying = false;
var inFlip = false;
var land = false;
var count=0;
var prevControls;

quad.connect(function(err) {
    if (err) console.log(err);
    quad.setup(function(err) {
        if (err) console.log(err);
        quad.flatTrim();
        quad.startPing();
        quad.flatTrim();
        
client.connect(PORT, HOST, function() {

    console.log('CONNECTED TO: ' + HOST + ':' + PORT);
    // Write a message to the socket as soon as the client is connected, the server will receive it as message from the client 
   // client.write('I am Chuck Norris!');

});

// Add a 'data' event handler for the client socket
// data is what the server sent to this socket

client.on('data', function(data) {

    console.log('DATA: ' + data);
	if (data == 3 && flying == false){
		quad.flatTrim();
         quad.takeoff();
         console.log('takeoff');
         flying = true;
         count=0;
}
	else if (data == 2 && flying==true && count<3){
	count=count+1;
}
	else if (data == 2 && flying== true && count >= 3){ 
				quad.land();
                flying = false;
                console.log('landing');
				count=0;
} 
else if (data == 6 && flying== true && inFlip == false){ 
				inFlip = true;
                quad.frontFlip(flipDone);
                console.log('frontflip');
                count=0;
}   
else if (data == 11 && flying== true && inFlip == false){ 
				inFlip = true;
                quad.backFlip(flipDone);
                console.log('backflip');
                count=0;
}
 else quad.hover();
    // Close the client socket completely
    //client.destroy();
    
});
});
});
function flipDone() {
    inFlip = false;
}

// Add a 'clos       joystick.on('data', function(buf) {
 /*           var controls = parseControls(buf);
            if (!prevControls)
                prevControls = controls;
            if (prevControls.buttons[0] === 0 && controls.buttons[0] === 1) {
                if (flying) {
                    quad.land();
                    flying = false;
                } else {
                    quad.flatTrim();
                    quad.takeoff();
                    flying = true;
                }
            }
            if (prevControls.view === 8 && controls.view !== 8)
                switch (controls.view) {
                    case 0:
                        inFlip = true;
                        quad.frontFlip(flipDone);
                        break;
                    case 2:
                        inFlip = true;
                        quad.rightFlip(flipDone);
                        break;
                    case 4:
                        inFlip = true;
                        quad.backFlip(flipDone);
                        break;
                    case 6:
                        inFlip = true;
                        quad.leftFlip(flipDone);
                        break;
                }
            prevControls = controls;
            if (flying && !inFlip) {
                if (controls.buttons[1]) {
                    quad.driveStepsRemaining = 1;
                    quad.speeds = {
                        yaw: 100 * (controls.yaw - 128) / 128,
                        pitch: -100 * (controls.pitch - 512) / 512,
                        roll: 100 * (controls.roll - 512) / 512,
                        altitude: 100 * (controls.throttle - 128) / 128
                    }
                } else quad.hover();
            }
            // console.log(JSON.stringify(controls));
        });
        joystick.on('error', function() {
            quad.land();
        });
    });
});

function flipDone() {
    inFlip = false;
}


function parseControls(buf) {
    var ch = buf.toString('hex').match(/.{1,2}/g).map(function(c) {
        return parseInt(c, 16);
    });
    return {
        roll: ((ch[1] & 0x03) << 8) + ch[0],
        pitch: ((ch[2] & 0x0f) << 6) + ((ch[1] & 0xfc) >> 2),
        yaw: ch[3],
        view: (ch[2] & 0xf0) >> 4,
        throttle: -ch[5] + 255,
        buttons: [
            (ch[4] & 0x01) >> 0, (ch[4] & 0x02) >> 1, (ch[4] & 0x04) >> 2, (ch[4] & 0x08) >> 3, (ch[4] & 0x10) >> 4, (ch[4] & 0x20) >> 5, (ch[4] & 0x40) >> 6, (ch[4] & 0x80) >> 7, (ch[6] & 0x01) >> 0, (ch[6] & 0x02) >> 1, (ch[6] & 0x04) >> 2, (ch[6] & 0x08) >> 3
        ]
    }
}e' event handler for the client socket
client.on('close', function() {
    console.log('Connection closed');
});

*/


//var hid = require('node-hid');
// console.log(hid.devices());
// Logitech Extreme 3D Pro's vendorID and productID: 1133:49685 (i.e. 046d:c215)
//var joystick = new hid.HID(1133, 49685);
// console.log(joystick);



 
