function refresh_div(micropostid) {
    $("#" + micropostid).unbind("click").bind("click")
}

