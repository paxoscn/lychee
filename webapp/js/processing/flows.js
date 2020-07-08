function createFlow() {
    location = "/processing/flow.htm"
}

function showFlowDetail(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/processing/flow.htm?id=" + el.obj.id
}

function showJobs(e) {
    var el = e.target
    while (typeof el.obj == "undefined") {
        el = el.parentNode
    }

    location = "/processing/jobs.htm?id=" + el.obj.id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/processing/flows', {}, function(res) {
        res.forEach(function(item) {
            tr($("flow-table"), item, [ item.name, item.crontabs, item.creator_id, item.created_on, "<button onclick='showFlowDetail(event)'>详情</button><button onclick='showJobs(event)'>查看任务</button>" ])
        })
    })
})
