S.configAll({
  "defaultToCurrentScreen" : true,
  "checkDefaultsOnLoad" : true,
  "orderScreensLeftToRight" : false
});

function bindAll() {
  /*
   * Quick app switching and launching
   * hyper + key to launch app or switch to it.
   * Use Karabiner to create hyper key, I use holding ';'.
   */
  bindQuickSwitch({
    "a:hyper" : "Android Studio",
    "c:hyper" : "Google Chrome",
    "f:hyper" : "Firefox",
    "i:hyper" : "iTerm",
    "k:hyper" : "Skype",
    "l:hyper" : "Flowdock",
    "m:hyper" : "Messages",
    "s:hyper" : "Safari",
    "x:hyper" : "Mailbox (Beta)"
  });

  /*
   * Size and move windows
   * Press binding twice to toggle between screens
   */
  bindWindowSizes({
    "i:ctrl,cmd"        : "fullscreen",
    "h:ctrl,cmd"        : "left",
    "h:ctrl,cmd,shift"  : "topLeft",
    "k:ctrl,cmd"        : "top",
    "k:ctrl,cmd,shift"  : "topRight",
    "l:ctrl,cmd"        : "right",
    "l:ctrl,cmd,shift"  : "bottomRight",
    "j:ctrl,cmd"        : "bottom",
    "j:ctrl,cmd,shift"  : "bottomLeft",
    "l:ctrl,cmd,alt"    : "rightThird",
    "h:ctrl,cmd,alt"    : "leftTwoThirds"
  });

  /*
   * These rely on two things being installed:
   * $ brew install terminal-notifier
   * $ rvmsudo rvm system do gem install hcl
   *
   * Plus the two scripts in my bin folder, hcl-start and hcl-stop.
   *
   * You will need to login and set up your tasks:
   * $ rvm system do hcl tasks
   */
  // bindHarvestCommands({
  //   "t:h,hyper" : { "name" : "Tch", "start" : "7700466 1658603" },
  //   "a:h,hyper" : { "name" : "Tch Android", "start" : "7876113 1658609" },
  //   "l:h,hyper" : { "name" : "Tch Labs", "start" : "7968887 1658603" },
  //   "i:h,hyper" : { "name" : "Internal", "start" : "7228599 1667144" },
  //   "n:h,hyper" : { "name" : "All Hands", "start" : "7228427 1667144" },
  //   "s:h,hyper" : { "name" : "Stop", "stop" : true },
  // })

  /*
   * Miscellaneous bindings
   */
  S.bindAll({
    "`:ctrl" : S.op("relaunch")
  });
}

var fullscreen = {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
};

var windowSizes = createWindowSizes(fullscreen, {
  "fullscreen" : {},
  "left" : { "width" : "screenSizeX / 2" },
  "topLeft" : {
    "width" : "screenSizeX / 2",
    "height" : "screenSizeY / 2"
  },
  "top" : { "height" : "screenSizeY / 2" },
  "topRight" : { "height" : "screenSizeY / 2" },
  "right" : {
    "x" : "screenOriginX + screenSizeX / 2",
    "width" : "screenSizeX / 2"
  },
  "bottomRight" : {
    "x" : "screenOriginX + screenSizeX / 2",
    "y" : "screenOriginY + screenSizeY / 2",
    "width" : "screenSizeX / 2",
    "height" : "screenSizeY / 2"
  },
  "bottom" : {
    "x" : "screenOriginX + screenSizeX / 2",
    "height" : "screenSizeY / 2"
  },
  "bottomLeft" : {
    "y" : "screenOriginY + screenSizeY / 2",
    "width" : "screenSizeX / 2",
    "height" : "screenSizeY / 2"
  },
  "rightThird" : {
    "x" : "screenOriginX + screenSizeX * 7 / 12",
    "width" : "screenSizeX * 5 / 12"
  },
  "leftTwoThirds" : { "width" : "screenSizeX * 7 / 12" },
});

var harvestTasks = {
  "Tch" : {
    "project_id" : "",
    "task_id" : ""
  }
}

function bindWindowSizes(bindings) {
  _.each(bindings, function(size, key) {
    key = expandModifiers(key);
    S.bind(key, function(win) {
      if (!win) return false;

      var origRect = win.rect();
      var move = S.op("move", windowSizes[size]);

      win.doOperation(move);

      if (rectEq(origRect, win.rect())) {
        move = move.dup({ "screen" : "next" });
        win.doOperation(move);
      }
    });
  });
};

function bindQuickSwitch(bindings) {
  _.each(bindings, function(app, key) {
    var appPath = "'/Applications/" + app + ".app'"
    key = expandModifiers(key);

    S.bind(key, function() {
      S.op("focus", { "app" : app }).run() ||
        S.shell("/usr/bin/open " + appPath);
    });
  });
}

function bindHarvestCommands(bindings) {
  var debug = false;
  _.each(bindings, function(task, key) {
    key = expandModifiers(key);
    if (task.start) {
      S.bind(key, function() {
        var result = S.shell("/Users/aaronjensen/.bin/hcl-start '" +
                          task.name + "' " + task.start, debug);
        if (debug) S.log(result);
      });
    } else if (task.stop ) {
      S.bind(key, function() {
        var result = S.shell("/Users/aaronjensen/.bin/hcl-stop", debug);
        if (debug) S.log(result);
      });
    }
  });
}

/*
 * Utility functions
 */
function rectEq(a, b) {
  return a.x === b.x &&
    a.y === b.y &&
    a.width === b.width &&
    a.height === b.height;
}

// Merge each size into the fullscreen size provided
function createWindowSizes(fullscreen, sizes) {
  windowSizes = {};

  _.each(sizes, function(size, name) {
    windowSizes[name] = _.extend({}, fullscreen, size);
  });

  return windowSizes;
}

function expandModifiers(bind) {
  return bind.replace("hyper", "ctrl,cmd,alt,shift");
}

bindAll();
