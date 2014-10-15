/**
 * Created by iivan on 10/14/14.
 */
var NOTIFY_ENDPOINT = '/assets/notify.html';

$(function () {
    $.ajax({
        url: NOTIFY_ENDPOINT,
        data: {"message": "I'm a notification!"}
    })
    var pusher = new Pusher('47997315232bbd9f561f');
    var channel = pusher.subscribe('my_notifications');
    var notifier = new PusherNotifier(channel);
//    channel.bind('my_event', function (data) {
//            console.log(data.message)
//    })
});