var flow_id = (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0)

function createJob() {
    location = "/processing/job.htm?flow_id=" + flow_id
}

window.addEventListener("load", function() {
    ajax('POST', '/api/processing/jobs', { "id": flow_id }, function(res) {
        renderSVG(res)
    })
})
