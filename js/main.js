requirejs.config({
    baseUrl: '../js',
    paths: {
        js: '../js'
    }
});

// Start loading the main app file. Put all of
// your application logic in there.


requirejs(['js/Auth.js']);
requirejs(['js/MainChat.js']);
requirejs(['js/Menu.js']);
requirejs(['js/Orders.js']);
requirejs(['js/Rooms.js']);
requirejs(['js/Chat.js']);