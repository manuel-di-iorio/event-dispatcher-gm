// EventDispatcher Test Suite
var d = new EventDispatcher();
show_debug_message("=== TEST SUITE: EventDispatcher ===");

// 1. Test 'on' and 'dispatch'
var t1_state = { success: false };
d.on("test", method(t1_state, function() { success = true; }));
d.dispatch({ type: "test" });
show_debug_message("Test 1 (Basic Dispatch): " + (t1_state.success ? "PASS" : "FAIL"));

// 2. Test Event Data
var t2_state = { data: undefined };
d.on("data", method(t2_state, function(e) { data = e.payload; }));
d.dispatch({ type: "data", payload: "hello" });
show_debug_message("Test 2 (Event Payload): " + (t2_state.data == "hello" ? "PASS" : "FAIL"));

// 3. Test 'off'
var t3_state = { count: 0 };
var t3_func = method(t3_state, function() { count++; });
d.on("off_test", t3_func);
d.off("off_test", t3_func);
d.dispatch({ type: "off_test" });
show_debug_message("Test 3 (Remove Listener): " + (t3_state.count == 0 ? "PASS" : "FAIL"));

// 4. Test 'once'
var t4_state = { count: 0 };
d.once("once_test", method(t4_state, function() { count++; }));
d.dispatch({ type: "once_test" });
d.dispatch({ type: "once_test" });
show_debug_message("Test 4 (Once Listener): " + (t4_state.count == 1 ? "PASS" : "FAIL (Count: " + string(t4_state.count) + ")"));

// 5. Test Multiple Listeners
var t5_state = { a: false, b: false };
d.on("multi", method(t5_state, function() { a = true; }));
d.on("multi", method(t5_state, function() { b = true; }));
d.dispatch({ type: "multi" });
show_debug_message("Test 5 (Multiple Listeners): " + (t5_state.a && t5_state.b ? "PASS" : "FAIL"));

// 6. Test 'off' with multiple listeners (remove middle one)
var t6_state = { log: [] };
var f1 = method(t6_state, function() { array_push(log, 1); });
var f2 = method(t6_state, function() { array_push(log, 2); });
var f3 = method(t6_state, function() { array_push(log, 3); });
d.on("order", f1);
d.on("order", f2);
d.on("order", f3);
d.off("order", f2);
d.dispatch({ type: "order" });
// Dispatch iterates backwards: 3, 1 (since 2 is removed)
var t6_pass = (array_length(t6_state.log) == 2 && t6_state.log[0] == 3 && t6_state.log[1] == 1);
show_debug_message("Test 6 (Remove Middle): " + (t6_pass ? "PASS" : "FAIL (Log: " + string(t6_state.log) + ")"));

show_debug_message("=== END TESTS ===");

/** FAST IMPLEMENTATION */

show_debug_message("");
show_debug_message("=== TEST SUITE: EventDispatcherFast ===");

enum EvT {
    TEST,
    DATA,
    OFF_TEST,
    ONCE_TEST,
    MULTI,
    ORDER,
    COUNT
}

var df = new EventDispatcherFast(EvT.COUNT);

// 1. Test 'on' and 'dispatch'
var tf1_state = { success: false };
df.on(EvT.TEST, method(tf1_state, function() { success = true; }));
df.dispatch({ type: EvT.TEST });
show_debug_message("Fast Test 1 (Basic Dispatch): " + (tf1_state.success ? "PASS" : "FAIL"));

// 2. Test Event Data
var tf2_state = { data: undefined };
df.on(EvT.DATA, method(tf2_state, function(e) { data = e.payload; }));
df.dispatch({ type: EvT.DATA, payload: "hello" });
show_debug_message("Fast Test 2 (Event Payload): " + (tf2_state.data == "hello" ? "PASS" : "FAIL"));

// 3. Test 'off'
var tf3_state = { count: 0 };
var tf3_func = method(tf3_state, function() { count++; });
df.on(EvT.OFF_TEST, tf3_func);
df.off(EvT.OFF_TEST, tf3_func);
df.dispatch({ type: EvT.OFF_TEST });
show_debug_message("Fast Test 3 (Remove Listener): " + (tf3_state.count == 0 ? "PASS" : "FAIL"));

// 4. Test 'once'
var tf4_state = { count: 0 };
df.once(EvT.ONCE_TEST, method(tf4_state, function() { count++; }));
df.dispatch({ type: EvT.ONCE_TEST });
df.dispatch({ type: EvT.ONCE_TEST });
show_debug_message("Fast Test 4 (Once Listener): " + (tf4_state.count == 1 ? "PASS" : "FAIL (Count: " + string(tf4_state.count) + ")"));

// 5. Test Multiple Listeners
var tf5_state = { a: false, b: false };
df.on(EvT.MULTI, method(tf5_state, function() { a = true; }));
df.on(EvT.MULTI, method(tf5_state, function() { b = true; }));
df.dispatch({ type: EvT.MULTI });
show_debug_message("Fast Test 5 (Multiple Listeners): " + (tf5_state.a && tf5_state.b ? "PASS" : "FAIL"));

// 6. Test 'off' with multiple listeners (remove middle one)
var tf6_state = { log: [] };
var ff1 = method(tf6_state, function() { array_push(log, 1); });
var ff2 = method(tf6_state, function() { array_push(log, 2); });
var ff3 = method(tf6_state, function() { array_push(log, 3); });
df.on(EvT.ORDER, ff1);
df.on(EvT.ORDER, ff2);
df.on(EvT.ORDER, ff3);
df.off(EvT.ORDER, ff2);
df.dispatch({ type: EvT.ORDER });
// Dispatch iterates backwards: 3, 1
var tf6_pass = (array_length(tf6_state.log) == 2 && tf6_state.log[0] == 3 && tf6_state.log[1] == 1);
show_debug_message("Fast Test 6 (Remove Middle): " + (tf6_pass ? "PASS" : "FAIL (Log: " + string(tf6_state.log) + ")"));

show_debug_message("=== END FAST TESTS ===");
