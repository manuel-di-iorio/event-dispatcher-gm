# Event Dispatcher

A lightweight **Event Dispatcher** implementation for GameMaker Studio 2 written in GML. It provides a simple publish‑subscribe mechanism that can be used across objects, scripts, and rooms.

## Features
- Register listeners with `on(eventType, listener)`
- Remove listeners with `off(eventType, listener)`
- Dispatch events with `dispatch({type: "event", data: …})`
- One‑time listeners with `once(eventType, listener)`
- Fully tested suite (see `rooms/Room1/RoomCreationCode.gml`)
- MIT licensed – free to use and modify.

## Installation
1. Copy the `scripts/Script1/Script1.gml` file into your GameMaker project (or place the code in a script named `EventDispatcher`).
2. Include the script where you need it, e.g.:
   ```gml
   var dispatcher = new EventDispatcher();
   ```

## Basic Usage
```gml
// Create a dispatcher
var ev = new EventDispatcher();

// Listen for an event
ev.on("player_hit", function(e) {
    show_debug_message("Player was hit! Damage: " + string(e.damage));
});

// Dispatch the event
ev.dispatch({ type: "player_hit", damage: 10 });

// One‑time listener
ev.once("game_start", function(){
    show_debug_message("Game started – this runs only once");
});
```

## Running the Test Suite
The test suite is located in the creation code of `Room1`, just run the game and see the debug window. The console will output the results of each test, e.g.:
```
=== TEST SUITE: EventDispatcher ===
Test 1 (Basic Dispatch): PASS
Test 2 (Event Payload): PASS
Test 3 (Remove Listener): PASS
Test 4 (Once Listener): PASS
Test 5 (Multiple Listeners): PASS
Test 6 (Remove Middle): PASS
=== END TESTS ===
```
All six tests should pass.

## Contributing
Feel free to fork the repository, open issues, or submit pull requests. Improvements such as additional event features, better error handling, or performance tweaks are welcome.

## License
This project is licensed under the MIT License – see the `LICENSE` file for details.
