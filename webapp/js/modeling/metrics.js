var metrics = null

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/metrics', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(item) {
        metrics = item
        $("id").value = metrics.id
        $("name").value = metrics.name
        $("cn_name").value = metrics.cn_name
        $("remarks").value = metrics.remarks
    })
})
