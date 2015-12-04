var port = process.env.PORT || 3000;
var myo = require('myo');
var net = require('net');

Myo.connect('com.ghirlekar.myocontrol');
Myo.on('connected', function() {
    console.log('Connected to Myo armband');
    var myMyo = Myo.myos[0];
    
    //myMyo.zeroOrientation();
    // console.log(myMyo.orientationOffset);  
    myMyo.streamEMG(true);
    net.createServer(function(client) {
        console.log('Client connected');
        client.on('end', function() {
            console.log('Client disconnected');
        });
        client.on('error', console.log);
        myMyo.on('emg', function(data1, timestamp) {
            // client.write(data.join(',').concat('\r\n'));
            //console.log(data)
           //client.write(Math.round(data.accelerometer.x*1000)/1000 + ',' + Math.round(data.accelerometer.y*1000)/1000 + ',' + Math.round(data.accelerometer.z*1000)/1000 + ',' + Math.round(data.gyroscope.x*1000)/1000 + ',' + Math.round(data.gyroscope.y*1000)/1000 + ',' + Math.round(data.gyroscope.z*1000)/1000 + ',' + Math.round(data.orientation.w*1000)/1000 + ',' + Math.round(data.orientation.x*1000)/1000 + ',' + Math.round(data.orientation.y*1000)/1000 + ',' + Math.round(data.orientation.z*1000)/1000 + '\r\n');
            client.write(data1.join(',').concat('\r\n') );
        });
        myMyo.on('imu', function(data, timestamp) {
            client.write(Math.round(data.accelerometer.x*1000)/1000 + ',' + Math.round(data.accelerometer.y*1000)/1000 + ',' + Math.round(data.accelerometer.z*1000)/1000 + ',' + Math.round(data.gyroscope.x*1000)/1000 + ',' + Math.round(data.gyroscope.y*1000)/1000 + ',' + Math.round(data.gyroscope.z*1000)/1000 + ',' + Math.round(data.orientation.w*1000)/1000 + ',' + Math.round(data.orientation.x*1000)/1000 + ',' + Math.round(data.orientation.y*1000)/1000 + ',' + Math.round(data.orientation.z*1000)/1000 + '\r\n');
    
        });
    }).listen(port, function() {
        console.log('TCP server listening for incoming connections on PORT: ' + port);
    });
});
