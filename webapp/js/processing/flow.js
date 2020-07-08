var flow = null

window.addEventListener("load", function() {
    ajax('POST', '/api/processing/flow', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(item) {
        flow = item
        $("id").value = flow.id
        $("name").value = flow.name
        $("crontabs").value = flow.crontabs
    })
})

function saveFlow() {
    flow.name = $("name").value
    flow.crontabs = $("crontabs").value
    ajax('POST', '/api/processing/flow-saving', flow, function(res) {
        location = "/processing/flows.htm"
    })
}
