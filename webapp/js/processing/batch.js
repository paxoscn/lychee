window.addEventListener("load", function() {
    ajax('POST', '/api/processing/batch', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(res) {
        renderSVG(res)
    })
})
