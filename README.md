# Event Dispatcher

A lightweight **Event Dispatcher** implementation for GameMaker Studio 2 written in GML. It provides a simple publish‑subscribe mechanism that can be used across objects, scripts, and rooms.

## Features
- Register listeners with `on(eventType, listener)`
- Remove listeners with `off(eventType, listener)`
- Dispatch events with `dispatch({type: "event", data: …})`
- One‑time listeners with `once(eventType, listener)`
- **High Performance**: Includes `EventDispatcherFast` for zero-overhead event dispatching using arrays and enums.
- Fully tested suite (see `rooms/Room1/RoomCreationCode.gml`)
- MIT licensed – free to use and modify.

## Installation
1. Copy the `scripts/EventDispatcher/EventDispatcher.gml` (Standard) or `scripts/EventDispatcherFast/EventDispatcherFast.gml` (Optimized) file into your project.
2. Include the script where you need it.

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

## High Performance Usage (EventDispatcherFast)
For performance-critical systems (e.g. per-frame events), use `EventDispatcherFast`. It uses **numeric enums** and **arrays** instead of string lookups, making it significantly faster.

1. Define your events in an `enum` (ensure to include a `COUNT` entry at the end).
2. Initialize `EventDispatcherFast` passing the total count.

```gml
// 1. Define events
enum GameEvent {
    PLAYER_JUMP,
    ENEMY_SPAWN,
    LEVEL_COMPLETE,
    COUNT // Required to size the array
}

// 2. Create the fast dispatcher
var fastEv = new EventDispatcherFast(GameEvent.COUNT);

// 3. Register listeners using enum values
fastEv.on(GameEvent.PLAYER_JUMP, function(e) {
    show_debug_message("Player jumped!");
});

// 4. Dispatch using enum values
fastEv.dispatch({ type: GameEvent.PLAYER_JUMP });
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

=== TEST SUITE: EventDispatcherFast ===
Fast Test 1 (Basic Dispatch): PASS
Fast Test 2 (Event Payload): PASS
Fast Test 3 (Remove Listener): PASS
Fast Test 4 (Once Listener): PASS
Fast Test 5 (Multiple Listeners): PASS
Fast Test 6 (Remove Middle): PASS
=== END FAST TESTS ===
```
All tests should pass.

## Contributing
Feel free to fork the repository, open issues, or submit pull requests. Improvements such as additional event features, better error handling, or performance tweaks are welcome.

## License
This project is licensed under the MIT License – see the `LICENSE` file for details.
