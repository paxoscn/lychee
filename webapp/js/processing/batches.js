function showBatchDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/processing/batch.htm?id=" + el.obj.id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/processing/batches', {}, function(res) {
        res.forEach(function(item) {
            tr($("batch-table"), item, [ item.is_adhoc, item.business_time, item.state, item.creator_id, item.created_on, "<button onclick='showBatchDetail(event)'>详情</button>" ])
        })
    })
})
