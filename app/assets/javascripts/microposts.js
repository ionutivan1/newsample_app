function refresh_div(micropostid, userid) {
    $("#" + micropostid).load("/users/" + userid + " #" + micropostid)
}


