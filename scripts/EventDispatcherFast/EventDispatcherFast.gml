/** EventDispatcherFast 
 * @param {number} eventCount - The number of event types.
 */

function EventDispatcherFast(eventCount) constructor {
    // Pre‑allocate an array where each index holds its own listener array.
    // eventCount should match the number of enum values you will use.
    _listeners = array_create(eventCount);
    for (var i = 0; i < eventCount; i++) {
        _listeners[i] = [];
    }

    /** Register a listener for a numeric event ID (enum value). */
    static on = function(eventId, listener) {
        if (eventId < 0 || eventId >= array_length(_listeners)) return; // safety check
        var list = _listeners[eventId];
        array_push(list, listener);
    }

    /** Remove a specific listener for a numeric event ID. */
    static off = function(eventId, listener) {
        if (eventId < 0 || eventId >= array_length(_listeners)) return;
        var list = _listeners[eventId];
        var idx = array_get_index(list, listener);
        if (idx != -1) {
            array_delete(list, idx, 1);
        }
    }

    /** Dispatch an event object where `type` is a numeric enum ID. */
    static dispatch = function(event) {
        var eventId = event.type;
        if (eventId < 0 || eventId >= array_length(_listeners)) return;
        var list = _listeners[eventId];
        
        // Attach target reference (optional, mirrors original implementation).
        event.target = self;
        
        // Iterate backwards to allow safe removal during iteration.
        for (var i = array_length(list) - 1; i >= 0; i--) {
            list[i](event);
        }
        
        event.target = undefined;
    }

    /** Register a one‑time listener that auto‑removes after first call. */
    static once = function(eventId, listener) {
        var _self = self;
        var ctx = { _self, eventId, listener, wrapper: undefined };
        ctx.wrapper = method(ctx, function(e) {
            _self.off(eventId, wrapper);
            listener(e);
        });
        self.on(eventId, ctx.wrapper);
    }
}
