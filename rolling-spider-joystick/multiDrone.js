'use strict';

var RollingSpider = require('rolling-spider');
var temporal = require('temporal');
var rollingSpider1 = new RollingSpider({uuid: 'e01473053d66', logger: console.log});
var rollingSpider2 = new RollingSpider({uuid: 'e01423523d49', logger: console.log});
var rollingSpider3 = new RollingSpider({uuid: 'e0142c9e3d49', logger: console.log});
rollingSpider1.connect(function () {
  rollingSpider1.setup(function () {
    rollingSpider1.flatTrim();
    rollingSpider1.startPing();
    rollingSpider1.flatTrim();

    temporal.queue([
      {
        delay: 3000,
        task: function () {
           rollingSpider1.flatTrim();
          rollingSpider1.takeOff();
        }
      },
      {
        delay: 3000,
        task: function () {
          rollingSpider1.frontFlip();
        }
      },
      {
        delay: 3000,
        task: function () {
          rollingSpider1.land();
        }
      },
      {
        delay: 3000,
        task: function () {
          temporal.clear();
          process.exit(0);
        }
      }
    ]);
  });
});

rollingSpider2.connect(function () {
  rollingSpider2.setup(function () {
    rollingSpider2.flatTrim();
    rollingSpider2.startPing();
    rollingSpider2.flatTrim();

    temporal.queue([
      {
        delay: 3000,
        task: function () {
          rollingSpider2.flatTrim();
          rollingSpider2.takeOff();
        }
      },
      {
        delay: 3000,
        task: function () {
          rollingSpider2.backFlip();
        }
      },
      {
        delay: 3000,
        task: function () {
          rollingSpider2.land();
        }
      },
      {
        delay: 3000,
        task: function () {
          temporal.clear();
          process.exit(0);
        }
      }
    ]);
  });
});

rollingSpider3.connect(function () {
  rollingSpider3.setup(function () {
    rollingSpider3.flatTrim();
    rollingSpider3.startPing();
    rollingSpider3.flatTrim();

    temporal.queue([
      {
        delay: 3000,
        task: function () {
          rollingSpider3.flatTrim();
          rollingSpider3.takeOff();
        }
      },
      {
        delay: 3000,
        task: function () {
          rollingSpider3.clockwise();
        }
      },
      {
        delay: 3000,
        task: function () {
          rollingSpider3.land();
        }
      },
      {
        delay: 3000,
        task: function () {
          temporal.clear();
          process.exit(0);
        }
      }
    ]);
  });
});

// 'use strict';

// var RollingSpider = require('rolling-spider');
// var temporal = require('temporal');
// var rollingSpider = new RollingSpider({logger: console.log});

// rollingSpider.connect(function () {
//   rollingSpider.setup(function () {
//     rollingSpider.flatTrim();
//     rollingSpider.startPing();
//     rollingSpider.flatTrim();

//     temporal.queue([
//       {
//         delay: 3000,
//         task: function () {
//           rollingSpider.flatTrim();
//           rollingSpider.takeOff();
//         }
//       },
//       {
//         delay: 2000,
//         task: function () {
//           rollingSpider.forward();
//         }
//       },
//       {
//         delay: 2000,
//         task: function () {
//           rollingSpider.land();
//         }
//       },
//       {
//         delay: 3000,
//         task: function () {
//           temporal.clear();
//           process.exit(0);
//         }
//       }
//     ]);
//   });
// });
